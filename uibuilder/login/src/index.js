// @ts-nocheck


'use strict'
const API_URL = 'http://127.0.0.1:1880';
const options = {
    transformAssetUrls: {
      video: ['src', 'poster'],
      source: 'src',
      img: 'src',
      image: 'xlink:href',
      'b-avatar': 'src',
      'b-img': 'src',
      'b-img-lazy': ['src', 'blank-src'],
      'b-card': 'img-src',
      'b-card-img': 'src',
      'b-card-img-lazy': ['src', 'blank-src'],
      'b-carousel-slide': 'img-src',
      'b-embed': 'src'
    }
  }
/** Simple example of using the uibuilder IIFE client build
 *  with Vue and bootstrap-vue.
 *
 * Note that uibuilder.start() should no longer be needed.
 * See the docs if the client doesn't start on its own.
 */

const app = new Vue({ // eslint-disable-line no-unused-vars
    el: '#app',

    data() { return {
        // Add reactive data variables here

        showLogin: true,
        showRegister: false,
        email: '',
        isEmailValid: null,
        emailFeedback: 'Ingresa una dirección de correo válida',
        password: '',
        isPasswordValid: null,
        passwordFeedback: 'Ingresa una contraseña válida',
        userToken: '',

    } }, // --- End of data --- //
    mounted() {
        if (localStorage.userToken) {
            this.userToken = localStorage.userToken;
        }
        if(localStorage.userEmail) {
            this.email = localStorage.userEmail;
        }
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
        cacheReplay: function(){
            uibuilder.send({payload: "Hi there from the client", topic: "from the client", cacheControl: "REPLAY"});
        },

        toggleBehaviour() {
            if(this.showRegister===false){
                this.showRegister=true;
                this.showLogin=false;
            }
            else{
                this.showRegister=false;
                this.showLogin=true;
            }
        },

        onSubmit() {
            const userId = this.email;
            const password = this.password;

            fetch(`${API_URL}/users/${userId}/authenticate`, {
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
                    const userToken = response.headers.get('authorization');
                    // Store the token in local storage
                    localStorage.setItem('userToken', userToken);
                    console.log(userToken);
                    console.log(response);//logs the response object
                    return response.json();
                })
                .then(data => {
                    // Handle the response data
                    const userEmail = data.UserId;
                    console.log(data);//logs whats entered, why?
                    localStorage.setItem('userEmail', userEmail);
                })
                .catch(error => {
                    // Handle any errors
                    console.error('Login error:', error);
                });
          },

        onRegister() {
            const userId = this.email;

            fetch(`${API_URL}/users/${userId}/register`, {
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

            
            const config = {
                headers: {
                    "Content-Type": "application/json"
                }
            };
        },
        
        validateEmail() {
        this.isEmailValid = this.email.match(/^.+@.+\..+$/i) !== null
        },

        validatePassword() {
            this.isPasswordValid = this.password.length >= 10
        },

        // REALLY Simple method to return DOM events back to Node-RED.
        doEvent: (event) => uibuilder.eventSend(event),

        /** Workaround to show "toast" notifications dynamically using bootstrap-vue's toast notifications.
         * This overrides uibuilder's default notification overlay which needs one of the uib CSS files.
         * @param {object} msg msg from Node-RED
         */
        showToast: function(msg) {
            // Only works with global notification msg's
            if ( !(msg._uib && msg._uib.componentRef && msg._uib.componentRef === 'globalNotification') ) return

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
            if ( options.title ) {
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

    /** Called after the Vue app has been created. A good place to put startup code */
    created: function() {

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
