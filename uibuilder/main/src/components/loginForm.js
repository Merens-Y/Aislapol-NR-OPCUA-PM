//http://127.0.0.1:1880 for localhost, must define for later stages of developent.
// const api_url = 'http://192.168.1.104:1880';
export default {
    // Component options: template, data, methods, etc.
    props: ['api_url'],
    template: `
    <b-container fluid>
        <b-container fluid v-if="showLogin">
            <b-row>
                <b-col md="6" class="mx-auto">
                    <h1>Inicia Sesión</h1>
                    <b-form class="position-relative p-3" @submit.prevent="triggerOnSubmit">
                        <b-form-group id="emailGroup" label="Correo:" label-for="emailInput" label-cols-lg="3" :state="isEmailValid" :invalid-feedback="emailFeedback">
                            <b-input-group>
                                <b-input-group-prepend is-text>
                                    <b-icon icon="envelope-fill"></b-icon>
                                </b-input-group-prepend>
                                <b-form-input :state="isEmailValid" id="emailInput" v-model="email" type="email" required @input="validateEmail"></b-form-input>
                            </b-input-group>
                        </b-form-group>
                        <b-form-group id="passwordGroup" label="Contraseña:" label-for="passwordInput" label-cols-lg="3" :state="isPasswordValid" :invalid-feedback="passwordFeedback">
                            <b-input-group>
                                <b-input-group-prepend is-text>
                                    <b-icon icon="key-fill"></b-icon>
                                </b-input-group-prepend>
                                <b-form-input :state="isPasswordValid" id="passwordInput" v-model="password" type="password" required @input="validatePassword"></b-form-input>
                            </b-input-group>
                        </b-form-group>
                        
                        <div class="d-flex justify-content-around align-items-center mt-4">
                            <b-button type="submit" variant="primary" :disabled="!isFormValid">Ingresar</b-button>
                            <b-button variant="secondary" @click="toggleBehaviour">Registrar</b-button>
                        </div>
                    </b-form>
                </b-col>
            </b-row>
        </b-container>
        <b-container fluid v-if="showRegister">
            <b-row>
                <b-col md="6" class="mx-auto">
                    <h1>Regístrate</h1>
                    <b-form class="position-relative p-3" v-if="!showPasswordForm" @submit.prevent="triggerRegister">
                        <b-form-group id="emailGroup2" label="Correo:" label-for="emailInput" :state="isEmailValid" :invalid-feedback="emailFeedback">
                            <b-input-group>
                                <b-input-group-prepend is-text>
                                    <b-icon icon="envelope-fill"></b-icon>
                                </b-input-group-prepend>
                                <b-form-input :state="isEmailValid" id="emailInput" v-model="email" type="email" required @input="validateEmail"></b-form-input>
                            </b-input-group>
                        </b-form-group>
                        <div class="d-flex justify-content-around align-items-center mt-4">
                            <b-button @click="triggerRegister" variant="primary" :disabled="!isEmailValid">Registrar</b-button>
                            <b-button variant="secondary" @click="toggleBehaviour">Iniciar Sesión</b-button>
                        </div>
                    </b-form>
                    <b-form class="position-relative p-3" v-if="showPasswordForm" @submit.prevent="triggerSubmitPasswordForm">
                        <b-form-group id="emailGroup3" label="Correo" label-for="emailInput" :state="isEmailValid" label-cols-lg="3" :invalid-feedback="emailFeedback">
                            <b-input-group>
                                <b-input-group-prepend is-text>
                                    <b-icon icon="envelope-fill"></b-icon>
                                </b-input-group-prepend>
                                <b-form-input :disabled="!editMail" :state="isEmailValid" id="emailInput" v-model="email" type="email" required @input="validateEmail"></b-form-input>
                                <b-input-group-append>
                                    <b-button variant="primary" @click="editRegisterMail" v-if="!editMail"><b-icon icon="pencil-fill"></b-icon></b-button>
                                    <b-button variant="success" @click="finishEditMail" v-if="editMail"><b-icon icon="check"></b-icon></b-button>
                                    <b-button variant="danger" @click="cancelEditMail" v-if="editMail"><b-icon icon="x"></b-icon></b-button>
                                </b-input-group-append>
                            </b-input-group>
                        </b-form-group>
                        <b-form-group id="passwordGroup2" label="Contraseña" label-for="passwordInput" label-cols-lg="3" :invalid-feedback="passwordFeedback" :state="isPasswordValid">
                            <b-input-group>
                                <b-input-group-prepend is-text>
                                    <b-icon icon="key-fill"></b-icon>
                                </b-input-group-prepend>
                                <b-form-input :state="isPasswordValid" id="passwordInput" v-model="password" required type="password" @input="validatePassword"></b-form-input>
                            </b-input-group>
                        </b-form-group>
                        <b-form-group id="confirmPasswordGroup" label="Confirmar Contraseña" label-for="confirmPasswordInput" label-cols-lg="3" :invalid-feedback="confirmPasswordFeedback" :state="isPasswordConfirmed">
                            <b-input-group>
                                <b-input-group-prepend is-text>
                                    <b-icon icon="key"></b-icon>
                                </b-input-group-prepend>
                                <b-form-input :state="isPasswordConfirmed" id="confirmPasswordInput" v-model="confirmPassword" required type="password" @input="validateConfirmPassword"></b-form-input>
                            </b-input-group>
                        </b-form-group>
                        <b-form-group id="confirmTokenGroup" label="Token de Confirmación" label-for="confirmTokenInput" label-cols-lg="3">
                            <b-input-group>
                                <b-input-group-prepend is-text>
                                    <b-icon icon="braces"></b-icon>
                                </b-input-group-prepend>
                                <b-form-input id="confirmTokenInput" v-model="confirmationToken" required></b-form-input>
                            </b-input-group>
                        </b-form-group>
                        <div class="d-flex justify-content-around align-items-center mt-4">
                            <b-button type="submit" variant="primary" :disabled="!confirmPasswordForm">Finalizar</b-button>
                            <b-button @click="triggerResendEmail" variant="success" :disabled="resendEmailDisabled">Reenviar Token</b-button>                        
                            <b-button variant="secondary" @click="toggleBehaviour">Volver a Iniciar Sesión</b-button>
                        </div>
                    </b-form>
                </b-col>
            </b-row>
        </b-container>
    </b-container>
    `,
    data() {
        return {
            showLogin: true,
            showRegister: false,
            // email data
            email: '',
            auxEmail: '',
            isEmailValid: null,
            emailFeedback: 'Ingresa una dirección de correo válida.',
            editMail: false,
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
            return (this.isPasswordConfirmed && this.isPasswordValid) && (this.confirmationToken!=='' && this.isEmailValid);
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
        editRegisterMail() {
            this.editMail = !this.editMail;
            this.auxEmail = this.email;
        },
        cancelEditMail() {
            this.editMail = !this.editMail;
            this.email = this.auxEmail;
        },
        finishEditMail() {
            this.editMail = !this.editMail;
            this.auxEmail = this.email;
            this.triggerRegister();
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