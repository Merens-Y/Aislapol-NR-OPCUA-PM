export default {
    props: [''],
    template: `
    <b-container fluid>
        <b-row>
            <b-col lg="12" my="1">
                <b-form class="position-relative p-3"  @submit.prevent="triggerEmailConfirmation">
                    <b-form-group id="emailGroup3" label="Nuevo Correo" label-for="emailInput" :state="isEmailValid" label-cols-lg="3" :invalid-feedback="emailFeedback">
                        <b-input-group>
                            <b-input-group-prepend is-text>
                                <b-icon icon="envelope-fill"></b-icon>
                            </b-input-group-prepend>
                            <b-form-input :state="isEmailValid" id="emailInput" v-model="email" type="email" required @input="validateEmail"></b-form-input>
                            <b-input-group-append>
                                <b-button variant="primary" :disabled="!isEmailValid" @click="triggerEmailChange">Solicitar Cambio</b-button>
                            </b-input-group-append>
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
                <b-button type="submit" variant="primary" :disabled="!confirmPasswordForm"><b-icon icon="check-all"></b-icon> Realizar</b-button>
                </b-form>
            </b-col>
        </b-row>
    </b-container>
    `,
    data() {
        return {
            email: '',
            isEmailValid: null,
            emailFeedback: 'Ingresa una dirección de correo válida.',
            confirmationToken: '',
        }
    },
    methods: {
        validateEmail() {
            this.isEmailValid = this.email.match(/^.+@.+\..+$/i) !== null;
        },
        triggerEmailChange() {
            const email = this.email;
            this.$emit('emailchange-event', email);
        },
        triggerEmailConfirmation() {
            const email = this.email;
            const confirmationToken = this.confirmationToken;
            this.$emit('emailconfirmation-event', email, confirmationToken);
        }
    },
    computed: {
        isEmailValid() {
            return this.isEmailValid === true;
        },
        confirmPasswordForm() {
            return (this.confirmationToken !== '' && this.isEmailValid);
        }
    },
};