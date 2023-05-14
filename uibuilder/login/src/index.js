import axios from 'axios';

// export default for axios, that way we can use it elsewhere. we set the entry point below as: 'http://127.0.0.1:1880/'
export default {
    methods: {
      fetchData() {
        axios.get('/api/data')
          .then(response => {
            console.log(response.data);
          })
          .catch(error => {
            console.error(error);
          });
      },
    },
  };

// @ts-nocheck
'use strict'
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
        emailState: null,
        emailFeedback: 'Ingresa una dirección de correo válida',
        password: '',
        passwordState: null,
        passwordFeedback: 'Ingresa una contraseña válida',

    } }, // --- End of data --- //

    computed: {
        isEmailValid() {
            return this.emailState === true
        },

        isPasswordValid() {
            return this.passwordState === true
        },

        isFormValid() {
            return this.isEmailValid && this.isPasswordValid
        },
    },

    methods: {
        cacheReplay: function(){
            uibuilder.send({payload: "Hi there from the client", topic: "from the client", cacheControl: "REPLAY"});
        },

        toggleRegister() {
            if(this.showRegister===false){
                this.showRegister=true;
                this.showLogin=false;
            }
        },

        toggleLogin() {
            if(this.showLogin===false){
                this.showRegister=false;
                this.showLogin=true;
            }
        },

        onSubmit() {
            // send http request to login
          },

        register() {
        // send http request to register
        },

        validateEmail() {
        this.emailState = this.email.match(/^.+@.+\..+$/i) !== null
        },

        validatePassword() {
            this.passwordState = this.password.length >= 12
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
