// @ts-nocheck
'use strict'
import PermittedUsers from './components/addPermitedUsers.js'
import LoginForms from './components/loginForm.js'
import MachineData from './components/machineData.js'
import AdminData from './components/adminData.js'
//http://127.0.0.1:1880 for localhost, must define for later stages of developent.
// const api_url = 'http://192.168.1.104:1880';

/** Simple example of using the uibuilder IIFE client build
 *  with Vue and bootstrap-vue.
 *
 * Note that uibuilder.start() should no longer be needed.
 * See the docs if the client doesn't start on its own.
 */

const app = new Vue({ // eslint-disable-line no-unused-vars
    el: '#app',
    components: {
        permittedusers: PermittedUsers,
        loginforms: LoginForms,
        machinedata: MachineData,
        admindata: AdminData,
    },
    data() {
        return {
            // Add reactive data variables here
            api_url: 'http://192.168.1.104:1880',
            showSkeleton: true,
            isLoggedIn: false,
            pre_exp_arr: [{}, {}],
            mold_arr: [{}, {}],
            email: '',
            userToken: '',
            isAdmin: false,
            showAdminTools: false,
        }
    }, // --- End of data --- //
    mounted() {
        if (localStorage.getItem('userToken')) {
            this.userToken = localStorage.getItem('userToken');
        }
        if (localStorage.getItem('userEmail')) {
            this.email = localStorage.getItem('userEmail');
        }
        // Check login status first, can't show or load if user is not logged.
        this.checkLoginStatus();
        setTimeout(() => {
            this.showSkeleton = false;
        }, 1500); // Adjust the duration as needed
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
        async checkLoginStatus() {
            const userId = localStorage.getItem('userEmail');
            const bearerToken = localStorage.getItem('userToken');
            let userToken = null;

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
                        }
                        else {
                            this.isAdmin = false;
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
                console.log("usertoken is not null");
                this.isLoggedIn = true;
                localStorage.setItem('userToken', userToken);
                localStorage.setItem('userEmail', userId);
                this.email = userId;
            }
        },
        logout() {
            // Clear the bearer token and admin data from local storage
            localStorage.removeItem('userToken');
            localStorage.removeItem('adminPermittedUsers');

            // Set isLoggedIn to false
            this.isLoggedIn = false;
            this.isAdmin = false;
            this.showAdminTools = false;
            this.adminPermittedUsers = [];
        },
        toggleAdminTools() {
            if (this.showAdminTools !== true) {
                this.showAdminTools = true;
            }
            else {
                this.showAdminTools = false;
            }
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
