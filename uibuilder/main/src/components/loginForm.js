//http://127.0.0.1:1880 for localhost, must define for later stages of developent.
// const api_url = 'http://192.168.1.104:1880';
export default {
    // Component options: template, data, methods, etc.
    props: ['api_url'],
    template: `
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
            <b-form v-if="!showPasswordForm" @submit.prevent="submitEmailForm">
                <h1>Regístrate</h1>
                <div class="w-100"></div>
                <b-form-group
                id="emailGroup2" label="Dirección de correo:" label-for="emailInput"
                :state="isEmailValid"
                :invalid-feedback="emailFeedback">
                <b-form-input id="emailInput" v-model="email" type="email" required @input="validateEmail"></b-form-input>
                </b-form-group>      
                <div class="row">
                    <b-button @click="submitEmailForm" variant="primary" :disabled="!isEmailValid">Registrar</b-button>
                    <div class="p-1">o</div>
                    <b-button variant="secondary" @click="toggleBehaviour">Iniciar Sesión</b-button>
                </div>
            </b-form>
            <b-form v-if="showPasswordForm" @submit.prevent="submitPasswordForm">
                <b-form-group
                id="passwordGroup2"
                label="Contraseña"
                label-for="passwordInput"
                :invalid-feedback="passwordFeedback"
                :state="isPasswordValid"
                >
                <b-form-input
                    id="passwordInput"
                    v-model="password"
                    required
                    type="password"
                    @input="validatePassword"
                ></b-form-input>
                </b-form-group>

                <b-form-group
                id="confirmPasswordGroup"
                label="Confirmar Contraseña"
                label-for="confirmPasswordInput"
                :invalid-feedback="confirmPasswordFeedback"
                :state="isPasswordConfirmed"
                >
                <b-form-input
                    id="confirmPasswordInput"
                    v-model="confirmPassword"
                    required
                    type="password"
                    @input="validateConfirmPassword"
                ></b-form-input>
                </b-form-group>
        
                <b-form-group
                id="confirmTokenGroup"
                label="Confirmation Token"
                label-for="confirmTokenInput"
                >
                <b-form-input
                    id="confirmTokenInput"
                    v-model="confirmationToken"
                    required
                ></b-form-input>
                </b-form-group>
                <div class="row">
                <b-button type="submit" variant="primary">Finalizar Registro</b-button>
                <b-button @click="resendEmail" :disabled="!confirmPasswordForm">
                    Reenviar correo de confirmación
                </b-button>
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
            // email data
            email: '',
            isEmailValid: null,
            emailFeedback: 'Ingresa una dirección de correo válida.',
            // password data
            password: '',
            isPasswordValid: null,
            passwordFeedback: 'Ingresa una contraseña válida.',
            // password data
            confirmPassword: '',
            isPasswordConfirmed: null,
            confirmPasswordFeedback: 'Las contraseñas deben ser idénticas.',
            // user data
            userToken: '',
            confirmationToken: '',
            // form logic data
            showPasswordForm: false,
            resendEmailDisabled: false,
        }
    },
    mounted() {
        if (localStorage.userToken) {
            this.userToken = localStorage.userToken;
        }
        if(localStorage.userEmail) {
            this.email = localStorage.userEmail;
        }
        console.log(this.api_url);
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
        confirmPasswordForm() {
            return (this.isPasswordConfirmed && this.isPasswordValid) && this.isEmailValid;
        }
    },
    methods: {
        resendEmail() {
            // Disable the button for 60 seconds
            this.resendEmailDisabled = true;
            setTimeout(() => {
              this.resendEmailDisabled = false;
            }, 60000);
      
            // Perform the email resend logic
        },
        //provisorio, final va en onRegister()
        submitEmailForm() {
            this.showPasswordForm = true;
        },
        submitPasswordForm() {
            if (!this.validatePassword()) {
                return; // Don't proceed if password is not valid
            }
            
            // Make the fetch post request and handle accordingly
        },
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
        async onRegister() {
            const userId = this.email;

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
        validateEmail() {
            this.isEmailValid = this.email.match(/^.+@.+\..+$/i) !== null
        },
        validatePassword() {
            this.isPasswordValid = this.password.length >= 10
        },
        validateConfirmPassword() {
            this.isPasswordConfirmed = this.confirmPassword === this.password
        },
    },
}