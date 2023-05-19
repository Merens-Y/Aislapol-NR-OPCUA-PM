export default {
  // Component options: template, data, methods, etc.
  template: `
    <div class="container">
        <b-form @submit.prevent="triggerInsertUsers">
        <div v-for="(user, index) in newPermittedUsers" :key="index">
            <b-form-row>
                <b-col cols="6">
                    <b-form-group label="Correo de Usuario" label-for="userEmailInput" :invalid-feedback="emailFeedback" :state="user.isValid">
                    <b-form-input
                        id="userEmailInput"
                        v-model="user.email"
                        required
                        placeholder="usuario@correo.cl"
                        @input="validateEmail(user, index)"
                    ></b-form-input>
                    </b-form-group>
                </b-col>

                <b-col cols="4">
                    <b-form-group label="Rol de Usuario" label-for="userRoleSelect">
                    <b-form-select
                        id="userRoleSelect"
                        v-model="user.role"
                        value="ninguno"
                        :options="roleOptions"
                        required
                    ></b-form-select>
                    </b-form-group>
                </b-col>

                <b-col cols="2" class="d-flex align-items-center justify-content-center">
                        <b-button
                            variant="danger"
                            size="sm"
                            class="mt-2"
                            v-if="index > 0"
                            @click="removeUser(index)"
                        >
                            Remover
                        </b-button>
                </b-col>
            </b-form-row>   
        </div>

        <b-button variant="primary" size="sm" @click="addUser">
            Añadir Usuario
        </b-button>

        <b-button type="submit" size="sm" :disabled="!isAllValid">Permitir Usuario(s)</b-button>
        </b-form>
    </div>
    `,
  data() {
    return {
      newPermittedUsers: [
        { email: '', role: 'ninguno', isValid: false } // Initial row
      ],
      roleOptions: ['user-admin', 'ninguno'], // Array of role options
      emailFeedback: 'Ingresa una dirección de correo válida.',
      isAllValid: false,
    };
  },
  watch: {
    newPermittedUsers: {
      handler() {
        // Perform the necessary checks on the objectArray
        // Update the isDisabled variable based on the assessment
        this.isAllValid = this.newPermittedUsers.every(user => user.isValid);
      },
      deep: true // Watch for changes in nested properties of the objectArray
    }
  },
  mounted() {},
  methods: {
    // functions unique of this component, the rest should be triggers to main Vue instance methods.
    validateEmail(user, index) {
      this.newPermittedUsers.at(index).isValid = user.email.match(/^.+@.+\..+$/i) !== null
    },
    addUser() {
      this.newPermittedUsers.push({ email: '', role: 'ninguno' });
    },
    removeUser(index) {
      if (index > 0) {
        this.newPermittedUsers.splice(index, 1);
      }
    },
    // triggers for methods in main vue instance.
    triggerInsertUsers() {
      // pass new users as argument.
      const newUsers = this.newPermittedUsers;
      this.$emit('insertpu-event', newUsers);
    },
  },
  computed: {},
};