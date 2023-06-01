export default {
    props: [''],
    template: `
    <b-container fluid>
        <b-form class="position-relative p-3" @submit.prevent="triggerOnSubmit">
            <b-form-group id="passwordGroup" label="Contraseña Actual" label-for="passwordInput" label-cols-lg="3" :invalid-feedback="passwordFeedback" :state="isPasswordValid">
                <b-input-group>
                    <b-input-group-prepend is-text>
                        <b-icon icon="key-fill"></b-icon>
                    </b-input-group-prepend>
                    <b-form-input :state="isPasswordValid" id="passwordInput" v-model="password" required type="password" @input="validatePassword"></b-form-input>
                </b-input-group>
            </b-form-group>

            <b-form-group :state="isNewPasswordValid" id="newPasswordGroup" label="Contraseña Nueva" label-for="newPasswordInput" label-cols-lg="3" :invalid-feedback="passwordFeedback">
                <b-input-group>
                    <b-input-group-prepend is-text>
                        <b-icon icon="key"></b-icon>
                    </b-input-group-prepend>
                    <b-form-input :state="isNewPasswordValid" id="newPasswordInput" v-model="newPassword" required type="password" @input="validateNewPassword"></b-form-input>
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
            <b-button type="submit" variant="primary" :disabled="!isPasswordValid || !isNewPasswordValid || !confirmPasswordForm">Cambiar Contraseña</b-button>
        </b-form>
    </b-container>
    `,
    data() {
        return {
            // password data
            password: '',
            isPasswordValid: null,
            passwordFeedback: 'Ingresa una contraseña válida.',
            // new password data
            newPassword: '',
            isNewPasswordValid: null,
            // confirm password data
            confirmPassword: '',
            isPasswordConfirmed: null,
            confirmPasswordFeedback: 'Las contraseñas deben ser idénticas.',
        }
    },
    methods: {
        validatePassword() {
            this.isPasswordValid = this.password.length >= 10
        },
        validateNewPassword() {
            this.isNewPasswordValid = this.newPassword.length >= 10;
        },
        triggerOnSubmit() {
            if (this.isPasswordValid && this.isNewPasswordValid) {
                const password = this.password;
                const newPassword = this.newPassword;
                this.$emit('password-reset', password, newPassword);
            }
        },
        validateConfirmPassword() {
            this.isPasswordConfirmed = this.confirmPassword === this.newPassword
        },
    },
    computed: {
        isPasswordValid() {
            return this.isPasswordValid === true;
        },
        isNewPasswordValid() {
            return this.isNewPasswordValid === true;
        },
        confirmPasswordForm() {
            return (this.isPasswordConfirmed && this.isPasswordValid) && (this.isNewPasswordValid);
        },
    },
};