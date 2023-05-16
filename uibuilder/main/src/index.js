// @ts-nocheck
'use strict' 
//http://127.0.0.1:1880 for localhost, must define for later stages of developent.
const API_URL = 'http://192.168.1.104:1880';
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

Vue.component('login-form', {
    // Component options: template, data, methods, etc.
    template:`
    <div fluid class="col-xl">
        <b-container fluid class="d-flex" v-if="showLogin">
            <div class="row">
                <h1>Inicia Sesión</h1>
                <div class="w-100"></div>
                <b-form @submit.prevent="onSubmit">
                    <b-form-group id="emailGroup" label="Dirección de correo:" label-for="emailInput"
                                    :state="isEmailValid"
                                    :invalid-feedback="emailFeedback">
                        <b-form-input id="emailInput" v-model="email" type="email" required
                                    @input="validateEmail"></b-form-input>
                    </b-form-group>
                
                    <b-form-group id="passwordGroup" label="Contraseña:" label-for="passwordInput"
                                    :state="isPasswordValid"
                                    :invalid-feedback="passwordFeedback">
                        <b-form-input id="passwordInput" v-model="password" type="password" required @input="validatePassword"></b-form-input>
                    </b-form-group>
                    <div class="row">
                        <b-button type="submit" variant="primary" :disabled="!isFormValid">Ingresar</b-button>
                        <div class="p-1">o</div>
                        <b-button variant="secondary" @click="toggleBehaviour">Registrar</b-button>
                    </div>                      
                    </b-form>
            </div>
        </b-container>
        <b-container fluid class="d-flex" v-if="showRegister">
            <div class="row">    
                <h1>Regístrate</h1>
                <div class="w-100"></div>
                <b-form @submit.prevent="onRegister">
                    <b-form-group id="emailGroup" label="Dirección de correo:" label-for="emailInput"
                                    :state="isEmailValid"
                                    :invalid-feedback="emailFeedback">
                        <b-form-input id="emailInput" v-model="email" type="email" required
                                    @input="validateEmail"></b-form-input>
                    </b-form-group>
                    <div class="row">
                        <b-button type="submit" variant="primary" :disabled="!isEmailValid">Registrar</b-button>
                        <div class="p-1">o</div>
                        <b-button variant="secondary" @click="toggleBehaviour">Iniciar Sesión</b-button>
                    </div>                      
                    </b-form>
            </div>
        </b-container>
    </div>
    `,
    data () {
        return{
            showLogin: true,
            showRegister: false,
            email: '',
            isEmailValid: null,
            emailFeedback: 'Ingresa una dirección de correo válida',
            password: '',
            isPasswordValid: null,
            passwordFeedback: 'Ingresa una contraseña válida',
            userToken: '',
        }
    },
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
        triggerLogin() {
            this.$emit('login-event');
        },

        triggerLogout() {
            this.$emit('logout-event');
        },

        async triggerCheckLogin() {
            this.$emit('checklogin-event');
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

        async onSubmit() {
            const userId = this.email;
            const password = this.password;
            let userToken = null;
            let userEmail = null;

            await fetch(`${API_URL}/users/${userId}/authenticate`, {
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
            
            if(userToken===null) {
                console.log("user token is null at this point");
                this.triggerLogout();
            }
            else {
                console.log("user token is not null at this point so we can proceed");
                this.triggerLogin();
                // Store the token and user email in local storage
                localStorage.setItem('userToken', userToken);
                localStorage.setItem('userEmail', userEmail);
                this.email = userId;
            }
            await this.triggerCheckLogin();
          },

        onRegister() {
            const userId = this.email;

            fetch(`${API_URL}/users/${userId}/register`, {
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
        
        validateEmail() {
            this.isEmailValid = this.email.match(/^.+@.+\..+$/i) !== null
        },

        validatePassword() {
            this.isPasswordValid = this.password.length >= 10
        },
    },
});

Vue.component('main-data', {
    props: ['pre_exp_arr', 'mold_arr'],
    template:`
    <div class="col-xl">
        <button class="p-3" @click="toggleMachines">Estado de Maquinarias</button>
        <button class="p-3" @click="toggleDatabase">Base de Datos</button>
        <button class="p-3" @click="toggleMonitor">Monitor de Variables productivas</button>
        <b-card v-if="showMachines">
            <div>{{ cacheReplay() }}</div>
            <h3 slot="header">Estado de Maquinarias</h3>
            <div class="row">
                <div class="card col-lg" v-for="pre_exp in pre_exp_arr" v-bind:class="[pre_exp.estado.texto]">
                        <div class="row">
                            <p class="col">Pre-Expansor {{pre_exp.numero}}</p> <div class="col-" v-bind:class="[pre_exp.estado.led]"></div>
                            <div class="w-100"></div>
                            <div class="col-sm"><p><b>Material:</b></p></div>                                
                            <div class="col-md value-field text-center">{{pre_exp.material}}</div>
                            <div class="w-100"></div>
                            <div class="col-sm"><p><b>Kg Procesados:</b></p></div>                                
                            <div class="col-md value-field text-center">{{pre_exp.kilog}}</div>
                            <div class="w-100"></div>
                            <div class="col-sm"><p><b>Kg Procesados:</b></p></div>                                
                            <div class="col-md value-field text-center">{{pre_exp.kilog}}</div>
                            <div class="w-100"></div>
                            <div class="col-sm"><p><b>Tiempo:</b></p></div>                                
                            <div class="col-md value-field text-center">{{pre_exp.tiempo}}</div>
                            <div class="w-100"></div>
                            <div class="col-sm"><p><b>Densidad:</b></p></div>                                
                            <b-col class="col-md value-field text-center">
                                <b-row class="no-gutters">
                                    <div class="col">{{pre_exp.densidad.min}}<br>min</div>
                                    <div class="col value-field">{{pre_exp.densidad.avg}}<br>prom</div>
                                    <div class="col value-field">{{pre_exp.densidad.max}}<br>max</div>
                                </b-row>
                                
                            </b-col>
                            <div class="w-100"></div>
                            <b-col class="p-3"></b-col> 
                        </div>                                                             
                    
                </div>
                <div class="card col-md" v-for="mold in mold_arr" v-bind:class="[mold.estado.texto]">
                    <div class="row">
                        <p class="col">Moldeador {{mold.numero}}</p> <div class="col-" v-bind:class="[mold.estado.led]"></div>
                        <div class="w-100"></div>
                        <div class="col-sm"><p><b>Molde:</b></p></div>
                        <div class="col-md value-field text-center">{{mold.molde}}</div>
                        <div class="w-100"></div>
                        <div class="col-sm"><p><b>Ciclos por Hora:</b></p></div>
                        <div class="col-md value-field text-center">{{mold.ciclos_hora}}</div>
                        <div class="w-100"></div>
                        <div class="col-sm"><p><b>Tiempo de Ciclo:</b></p></div>
                        <div class="col-md value-field text-center">{{mold.tiempo_ciclo}}</div>
                        <div class="w-100"></div>
                        <div class="col-sm"><p><b>Total de ciclos:</b></p></div>
                        <div class="col-md value-field text-center">{{mold.ciclos_total}}</div>                                                       
                    </div>
                </div>
            </div>
        </b-card>
        <b-card v-if="showDatabase">
            <h3 slot="header">Base de Datos</h3>
            <b-form-input id="type-search" placeholder="Ingresar Query"></b-form-input>
            <b-table striped hover :items="tableData"></b-table>
        </b-card>
        <b-card v-if="showMonitor">
            <h3 slot="header">Monitor de Variables Productivas</h3>
        </b-card>
    </div>
    `,
    data () {
        return{
            showMachines: false,
            showDatabase: false,
            showMonitor: false,
            showHomepage: true,
            tableData: [
                { age: 40, first_name: 'Dickerson', last_name: 'Macdonald' },
                { age: 21, first_name: 'Larsen', last_name: 'Shaw' },
                { age: 89, first_name: 'Geneva', last_name: 'Wilson' },
                { age: 38, first_name: 'Jami', last_name: 'Carney' }
            ],
        }
    },
    methods: {
        cacheReplay: function(){
            uibuilder.send({payload: "Hi there from the client", topic: "from the client", cacheControl: "REPLAY"});
        },

        toggleMachines: function(){
            if(this.showMachines===false){
                this.showMachines = true;
                this.showHomepage = false;
                this.showDatabase = false;
                this.showMonitor = false;
            }
        },

        toggleDatabase: function(){
            if(this.showDatabase===false){
                this.showMachines = false;
                this.showHomepage = false;
                this.showDatabase = true;
                this.showMonitor = false;
            }
        },

        toggleMonitor: function(){
            if(this.showMonitor===false){
                this.showMachines = false;
                this.showHomepage = false;
                this.showDatabase = false;
                this.showMonitor = true;
            }
        },
    },
});

const app = new Vue({ // eslint-disable-line no-unused-vars
    el: '#app',

    data() { return {
        // Add reactive data variables here
        isLoggedIn: false,
        pre_exp_arr: [{},{}],
        mold_arr: [{},{}],
        email: '',
        userToken: '',
        isAdmin: false,
    } }, // --- End of data --- //
    mounted() {
        if (localStorage.userToken) {
            this.userToken = localStorage.userToken;
        }
        if(localStorage.userEmail) {
            this.email = localStorage.userEmail;
        }
        // Check login status first, can't show or load if user is not logged.
        this.checkLoginStatus();
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
            await fetch(`${API_URL}/users/${userId}`, {
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
                else{
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
                if(roleData) {
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
            
            if(userToken===null) {
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
            // Clear the bearer token from local storage
            localStorage.removeItem('userToken');
        
            // Set isLoggedIn to false
            this.isLoggedIn = false;
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
