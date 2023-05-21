//http://127.0.0.1:1880 for localhost, must define for later stages of developent.
// const api_url = 'http://192.168.1.104:1880';
export default {
    // Component options: template, data, methods, etc.
    props: ['api_url'],
    template: `
    <div>
        <b-container fluid class="d-flex" v-if="showLogin">
            <div class="row">
                <h1>Inicia Sesión</h1>
                <div class="w-100"></div>
                <b-form @submit.prevent="triggerOnSubmit">
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
                    <b-row class="d-flex align-items-center justify-content-center">
                        <b-col><b-button type="submit" variant="primary" :disabled="!isFormValid">Ingresar</b-button></b-col>
                        <b-col><b-button variant="secondary" @click="toggleBehaviour">Registrar</b-button></b-col>
                    </b-row>
                    </b-form>
            </div>
        </b-container>
        <b-container fluid class="d-flex" v-if="showRegister">
            <b-row>
                <b-form v-if="!showPasswordForm" @submit.prevent="triggerRegister">
                    <h1>Regístrate</h1>
                    <div class="w-100"></div>
                    <b-form-group
                    id="emailGroup2" label="Dirección de correo:" label-for="emailInput"
                    :state="isEmailValid"
                    :invalid-feedback="emailFeedback">
                    <b-form-input id="emailInput" v-model="email" type="email" required @input="validateEmail"></b-form-input>
                    </b-form-group>      
                    <b-row class="d-flex align-items-center justify-content-center">
                        <b-col><b-button @click="triggerRegister" variant="primary" :disabled="!isEmailValid">Registrar</b-button></b-col>
                        <b-col><b-button variant="secondary" @click="toggleBehaviour">Volver a Iniciar Sesión</b-button></b-col>
                    </b-row>
                </b-form>
                <b-form v-if="showPasswordForm" @submit.prevent="triggerSubmitPasswordForm">
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
                    <b-row class="d-flex align-items-center justify-content-center">
                        <b-col><b-button type="submit" variant="primary" :disabled="!confirmPasswordForm">Finalizar Registro</b-button></b-col>
                        <b-col><b-button @click="triggerResendEmail" :disabled="resendEmailDisabled">
                            Reenviar correo de confirmación
                        </b-button></b-col>                        
                        <b-col><b-button variant="secondary" @click="toggleBehaviour">Volver a Iniciar Sesión</b-button></b-col>
                    </b-row>
                </b-form>
            </b-row>
        </b-container>
    </div>
    `,
    data() {
        return {
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
            // confirm password data
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
        if (localStorage.userEmail) {
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
        // Methods unique of this components go here:
        validateEmail() {
            this.isEmailValid = this.email.match(/^.+@.+\..+$/i) !== null
        },
        validatePassword() {
            this.isPasswordValid = this.password.length >= 10
        },
        validateConfirmPassword() {
            this.isPasswordConfirmed = this.confirmPassword === this.password
        },
        // Triggers for methods of the main Vue instance go here:
        triggerResendEmail() {
            // Perform the email resend logic
            const u_email = this.email;
            this.$emit('resendemail-event', u_email);
            // Disable the button for 60 seconds
            this.resendEmailDisabled = true;
            setTimeout(() => {
                this.resendEmailDisabled = false;
            }, 60000);
        },
        triggerSubmitPasswordForm() {
            const u_email = this.email;
            const u_password = this.password;
            const u_token = this.confirmationToken;
            // trigger the fetch post request and authentication logic on the main Vue instance.
            this.$emit('endregistration-event', u_email, u_password, u_token)
            // Toggle back to login form by setting the proper booleans
            this.showPasswordForm = false;
            this.toggleBehaviour();
        },
        triggerOnSubmit() {
            const userId = this.email;
            const password = this.password;
            this.$emit('submitlogin-event', userId, password);
        },
        triggerRegister() {
            this.showPasswordForm = true;
            const u_email = this.email;
            this.$emit('register-event', u_email);
        },
        toggleBehaviour() {
            if (this.showRegister === false) {
                this.showRegister = true;
                this.showLogin = false;
            }
            else {
                this.showRegister = false;
                this.showLogin = true;
            }
        },
    },
}