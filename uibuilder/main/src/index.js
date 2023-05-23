// @ts-nocheck
'use strict'
import AddPermittedUsers from './components/addPermittedUsers.js';
import LoginForms from './components/loginForm.js';
import MachineData from './components/machineData.js';
import AdminData from './components/editRegisteredUsers.js';
import EditTable from './components/editPermittedUsers.js';
import Database from './components/databaseQuery.js';
import { API_URL } from './components/api_url.js'

/** Simple example of using the uibuilder IIFE client build
 *  with Vue and bootstrap-vue.
 *
 * Note that uibuilder.start() should no longer be needed.
 * See the docs if the client doesn't start on its own.
 */

const app = new Vue({ // eslint-disable-line no-unused-vars
    el: '#app',
    components: {
        addpermittedusers: AddPermittedUsers,
        loginforms: LoginForms,
        machinedata: MachineData,
        admindata: AdminData,
        edittable: EditTable,
        database: Database,
    },
    data() {
        return {
            // Add reactive data variables here
            api_url: `http://${API_URL}:1880`,
            showSkeleton: true,
            isLoggedIn: false,
            pre_exp_arr: [{}, {}],
            mold_arr: [{}, {}],
            email: '',
            userToken: '',
            isAdmin: false,
            showAdminTools: false,
            admin_permitted_users: [],
            admin_registered_users: [],
        }
    }, // --- End of data --- //
    mounted() {
        if (localStorage.getItem('userToken')) {
            this.userToken = localStorage.getItem('userToken');
        }
        if (localStorage.getItem('userEmail')) {
            this.email = localStorage.getItem('userEmail');
        }
        if (localStorage.getItem('adminPermittedUsers')) {
            this.admin_permitted_users = JSON.parse(localStorage.getItem('adminPermittedUsers'));
        }
        if (localStorage.getItem('adminRegisteredUsers')) {
            this.admin_permitted_users = localStorage.getItem('adminRegisteredUsers');
        }
        // Check login status first, can't show or load if user is not logged.
        this.checkLoginStatus();
        setTimeout(() => {
            this.showSkeleton = false;
        }, 700); // Adjust the duration as needed
    },
    computed: {
        isEmailValid() {
            return this.isEmailValid === true;
        },

        isPasswordValid() {
            return this.isPasswordValid === true;
        },

        isFormValid() {
            return this.isEmailValid && this.isPasswordValid;
        },
    },

    methods: {
        // Utility methods
        makeToast(toastTitle = "Title", toastMessage = "message", variant=null, append = false) {
            this.$bvToast.toast(`${toastMessage}`, {
                title: `${toastTitle}`,
                autoHideDelay: 5000,
                appendToast: append,
                variant: variant,
            })
        },
        textResponsetoObject(data) {
            const lines = data.split('\n'); // Split the text into lines

            const users = lines.map(line => {
                const values = line.split(' '); // Split each line into values
                const email = values[0]; // First value is the email

                // Remaining values are roles, if any
                const roles = values.slice(1).filter(role => role !== '');

                return {
                    user_email: email,
                    roles: roles
                };
            });
            return users;
        },
        aPUtoText(aPU) {
            const permittedUsersList = aPU
                .map((user) => {
                    const roles = user.roles.length > 0 ? user.roles.join(' ') : '';
                    return `${user.user_email} ${roles}`;
                })
                .join('\n');
            return permittedUsersList;
        },
        nPUtoText(nPU) {
            const newUsersList = nPU
                .map((user) => {
                    let text = user.email;
                    if (user.role === 'user-admin') {
                        text += ` ${user.role}`;
                    } else if (user.role !== 'ninguno') {
                        text += ` ${user.role.join(' ')}`;
                    }
                    return text;
                })
                .join('\n');
            return newUsersList;
        },
        // Admin methods
        async getPermitted() {
            const bearerToken = localStorage.getItem('userToken');
            let userToken = null;
            let users = null;
            await fetch(`${this.api_url}/permitted-users`, {
                method: 'GET',
                headers: {
                    'Authorization': `${bearerToken}`,
                    'Content-Type': 'application/json',
                    // You can include additional headers if required
                },
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    userToken = response.headers.get('authorization');
                    console.log(userToken);//logs the user token
                    console.log(response);//logs the response object
                    return response.text();
                })
                .then(data => {
                    // Handle the response data
                    users = this.textResponsetoObject(data);
                    console.log(users);
                    this.admin_permitted_users = users;
                    console.log(data);
                })
                .catch(error => {
                    // Handle any errors
                    console.error('Admin error:', error);
                });

            if (userToken === null) {
                console.log("user token is null at this point");
                this.logout();
            }
            else {
                console.log("user token is not null at this point so we can proceed");
                console.log(users);
                // Store the token and user email in local storage
                localStorage.setItem('userToken', userToken);
                localStorage.setItem('adminPermittedUsers', JSON.stringify(users)); //remember to JSON.parse() it before using to get an object instead
            }
        },
        async getRegistered() {
            const bearerToken = localStorage.getItem('userToken');
            let userToken = null;
            let users = null;
            await fetch(`${this.api_url}/registered-users`, {
                method: 'GET',
                headers: {
                    'Authorization': `${bearerToken}`,
                    'Content-Type': 'application/json',
                    // You can include additional headers if required
                },
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    userToken = response.headers.get('authorization');
                    console.log(userToken);//logs the user token
                    console.log(response);//logs the response object
                    return response.json();
                })
                .then(data => {
                    // Handle the response data
                    users = data;
                    console.log(users);
                    this.admin_registered_users = users;
                    console.log(data);
                })
                .catch(error => {
                    // Handle any errors
                    console.error('Admin error:', error);
                });

            if (userToken === null) {
                console.log("user token is null at this point");
                this.logout();
            }
            else {
                console.log("user token is not null at this point so we can proceed");
                console.log(users);
                // Store the token and user email in local storage
                localStorage.setItem('userToken', userToken);
                localStorage.setItem('adminRegisteredUsers', users); //remember to JSON.parse() it before using to get an object instead
            }
        },
        async insertUsers(newPermittedUsers) {
            // Get list of already existing permitted users.
            await this.getPermitted();
            const permittedUsersList = this.aPUtoText(this.admin_permitted_users);
            // Get the token for authorization, if it doesn't match the api call won't work
            const bearerToken = localStorage.getItem('userToken');
            // Check if the users array is empty
            if (newPermittedUsers.length === 0 || bearerToken === undefined) {
                return; // Exit the method without executing further
            }
            // Convert new permitted users array to text file format
            const newUsersList = this.nPUtoText(newPermittedUsers)
            console.log(newUsersList);
            const combinedTextContent = permittedUsersList + '\n' + newUsersList;
            console.log(combinedTextContent);
            // Create request options
            const requestOptions = {
                method: 'PUT',
                headers: {
                    'Authorization': `${bearerToken}`,
                    'Content-Type': 'text/plain',
                },
                body: combinedTextContent,
            };

            // Send the PUT request
            try {
                const response = await fetch(`${this.api_url}/permitted-users`, requestOptions);
                // Handle the response as needed
                await this.getPermitted();
            } catch (error) {
                // Handle error
            }
        },
        async checkLoginStatus() {
            const userId = localStorage.getItem('userEmail');
            const bearerToken = localStorage.getItem('userToken');
            let userToken = null;
            let isUserAdmin = null;

            // Make an API call to validate the bearer token
            await fetch(`${this.api_url}/users/${userId}`, {
                method: 'GET',
                headers: {
                    'Authorization': `${bearerToken}`,
                    'Content-Type': 'application/json',
                },
            })
                .then(response => {
                    if (!response.ok) {
                        console.log("response is not OK!");
                        throw new Error('Request failed');
                    }
                    else {
                        // If token is valid, set isLoggedIn to true
                        console.log("entered else statement = response ok?");
                        console.log(response);
                        userToken = response.headers.get('authorization');
                        return response.json();
                    }
                })
                .then(data => {
                    // Handle the response data
                    console.log(data);
                    const roleData = data.Roles
                    console.log(roleData);
                    if (roleData) {
                        if (roleData.includes("user-admin")) {
                            this.isAdmin = true;
                            this.showAdminTools = true;
                            isUserAdmin = true;
                        }
                        else {
                            this.isAdmin = false;
                            this.showAdminTools = false;
                        }
                    }
                    else {
                        this.isAdmin = false;
                    }
                })
                .catch(error => {
                    // Handle the error
                    console.error('Authorization error:', error);
                });
            if (userToken === null) {
                console.log("usertoken is null");
                this.logout();
            }
            else {
                if (isUserAdmin === true) {
                    await this.getPermitted();
                    await this.getRegistered();
                }
                console.log("usertoken is not null");
                this.isLoggedIn = true;
                localStorage.setItem('userToken', userToken);
                localStorage.setItem('userEmail', userId);
                this.email = userId;
            }
        },
        async deleteUser(user_id) {
            const bearerToken = localStorage.getItem('userToken'); // Get the user token from local storage

            const requestOptions = {
                method: 'DELETE',
                headers: {
                    Authorization: bearerToken,
                },
            };

            await fetch(`${this.api_url}/users/${user_id}`, requestOptions)
                .then((response) => {
                    const newToken = response.headers.get('authorization'); // Get the new token from the response header
                    if (newToken) {
                        localStorage.setItem('userToken', newToken); // Update the user token in local storage
                    }
                    // Handle the response as needed
                    if (response.ok) {
                        this.makeToast('Admin', 'El usuario ha sido eliminado exitosamente.', 'success');
                        // Request was successful
                        console.log('User deleted successfully');
                        this.getRegistered();
                    } else {
                        // Request failed
                        console.error('Failed to delete user');
                    }
                })
                .catch((error) => {
                    console.error('Error:', error);
                });
        },
        async updateAdminUsers(users) {
            const bearerToken = localStorage.getItem('userToken');
            const updatedUsers = this.aPUtoText(users);
            // needs custom fetch for this maybe.
            const requestOptions = {
                method: 'PUT',
                headers: {
                    'Authorization': `${bearerToken}`,
                    'Content-Type': 'text/plain',
                },
                body: updatedUsers,
            };

            // Send the PUT request
            try {
                const response = await fetch(`${this.api_url}/permitted-users`, requestOptions);
                // Handle the response as needed
                await this.getPermitted();
            } catch (error) {
                // Handle error
            }
        },
        // Login and registration methods
        async onSubmit(u_email, u_password) {
            const userId = u_email;
            const password = u_password;
            let userToken = null;
            let userEmail = null;

            await fetch(`${this.api_url}/users/${userId}/authenticate`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    // You can include additional headers if required
                },
                body: JSON.stringify({
                    Password: password,
                }),
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    userToken = response.headers.get('authorization');
                    console.log(userToken);//logs the user token
                    console.log(response);//logs the response object
                    return response.json();
                })
                .then(data => {
                    // Handle the response data
                    userEmail = data.UserId;
                    console.log(data);
                })
                .catch(error => {
                    // Handle any errors
                    console.error('Login error:', error);
                });

            if (userToken === null) {
                console.log("user token is null at this point");
                this.logout();
            }
            else {
                console.log("user token is not null at this point so we can proceed");
                this.setLogged();
                // Store the token and user email in local storage
                localStorage.setItem('userToken', userToken);
                localStorage.setItem('userEmail', userEmail);
            }
            await this.checkLoginStatus();
        },
        async onRegister(email) {
            const userId = email;

            await fetch(`${this.api_url}/users/${userId}/register`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    // You can include additional headers if required
                },
                body: JSON.stringify({}),
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }

                    console.log(response);//logs the response object
                    return response.json();
                })
                .then(data => {
                    // Handle the response data
                    console.log(data);
                })
                .catch(error => {
                    // Handle any errors
                    console.error('Registration error:', error);
                });
        },
        async onSendConfirmation(email) {
            const userId = email;

            await fetch(`${this.api_url}/users/${userId}/send-confirmation-message`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    // You can include additional headers if required
                },
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }

                    console.log(response);//logs the response object
                    return response.json();
                })
                .then(data => {
                    // Handle the response data
                    console.log(data);
                })
                .catch(error => {
                    // Handle any errors
                    console.error('Registration error:', error);
                });
        },
        async confirmRegistration(email, password, confirmationToken) {
            const userId = email;
            const agreement = 'true';
            const newUserPassword = password;
            const token = confirmationToken;

            await fetch(`${this.api_url}/users/${userId}/confirm`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    // You can include additional headers if required
                },
                body: JSON.stringify({
                    Token: token,
                    newPassword: newUserPassword,
                    agreedToDPS: agreement,
                    agreedToTOS: agreement,
                }),
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }

                    console.log(response);//logs the response object
                    return response.json();
                })
                .then(data => {
                    // Handle the response data
                    console.log(data);
                })
                .catch(error => {
                    // Handle any errors
                    console.error('Registration error:', error);
                });

            await this.onSubmit(userId, newUserPassword);
        },
        logout() {
            // Clear the bearer token and admin data from local storage
            localStorage.removeItem('userToken');
            localStorage.removeItem('adminPermittedUsers');
            localStorage.removeItem('adminRegisteredUsers');

            // Set isLoggedIn to false
            this.isLoggedIn = false;
            this.isAdmin = false;
            this.showAdminTools = false;
            this.admin_permitted_users = [];
            this.admin_registered_users = [];
        },
        setLogged() {
            this.isLoggedIn = true;
        },
        // REALLY Simple method to return DOM events back to Node-RED.
        doEvent: (event) => uibuilder.eventSend(event),

        /** Workaround to show "toast" notifications dynamically using bootstrap-vue's toast notifications.
         * This overrides uibuilder's default notification overlay which needs one of the uib CSS files.
         * @param {object} msg msg from Node-RED
         */
        showToast: function (msg) {
            // Only works with global notification msg's
            if (!(msg._uib && msg._uib.componentRef && msg._uib.componentRef === 'globalNotification')) return

            // Is bootstrap-vue loaded? If not, show error
            if (!window['BootstrapVue']) {
                uibuilder.log('error', 'showToast Method', 'Bootstrap-vue not loaded, cannot show toast notification')
                return
            }

            const options = Object.assign({}, msg._uib.options)

            // $createElement is a Vue function that lets you create Vue virtual DOM
            // elements. We use it here to let us render HTML in the toast.
            const h = this.$createElement
            // Assume that the input content is or could be HTML. create a virtual DOM element
            const vNodesContent = h(
                'p', {
                domProps: {
                    innerHTML: options.content
                }
            }
            )

            // The title is also allowed to have HTML
            if (options.title) {
                options.title = h(
                    'p', {
                    domProps: {
                        innerHTML: options.title
                    }
                }
                )
            }

            if (options.variant === 'error') options.variant = 'danger'
            if (options.variant === 'warn') options.variant = 'warning'
            if (!options.solid) options.solid = true

            // Dynamically insert the toast to the virtual DOM
            // Will show at top-right of the HTML element that is the app root
            // unless you include a <b-toaster> element
            this.$bvToast.toast(vNodesContent, options)
        },

    }, // --- End of methods --- //

    // Available hooks: beforeCreate,created,beforeMount,mounted,beforeUpdate,updated,beforeDestroy,destroyed, activated,deactivated, errorCaptured
    watch: {
        userToken(newValue) {
            // Whenever the value of 'userToken' changes, update the local storage
            localStorage.setItem('userToken', newValue);
        }
    },
    /** Called after the Vue app has been created. A good place to put startup code */
    created: function () {
        const storedData = localStorage.getItem('userToken');
        if (storedData) {
            this.userToken = storedData; // Set the initial value to the data property
        }
        // If msg changes - msg is updated when a standard msg is received from Node-RED over Socket.IO
        uibuilder.onChange('msg', (msg) => {

            // Workaround to show "toast" notifications dynamically. See methods above.
            this.showToast(msg)
            if (msg.topic === 'pre-expansor') {
                // $(...) is a uibuilder helper function that selects an HTML element based on a CSS Selector
                // Use innerHTML if your payload includes additional HTML formatting

                this.pre_exp_arr = msg.payload;
            }
            if (msg.topic === 'moldeador') {
                // $(...) is a uibuilder helper function that selects an HTML element based on a CSS Selector
                // Use innerHTML if your payload includes additional HTML formatting

                this.mold_arr = msg.payload;
            }
        })

    }, // --- End of created hook --- //

}) // --- End of app1 --- //

// EOF
