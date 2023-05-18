//http://127.0.0.1:1880 for localhost, must define for later stages of developent.
// const api_url = 'http://192.168.1.104:1880';
export default {
  // Component options: template, data, methods, etc.
  props: ['api_url'],
  template: `
    <div class="container">
        <b-form @submit.prevent="insertUsers">
        <div v-for="(user, index) in users" :key="index">
            <b-form-row>
                <b-col cols="6">
                    <b-form-group label="Correo de Usuario" label-for="userEmailInput" :invalid-feedback="emailFeedback" :state="user.isValid">
                    <b-form-input
                        id="userEmailInput"
                        v-model="user.email"
                        required
                        @input="validateEmail(user, index)"
                    ></b-form-input>
                    </b-form-group>
                </b-col>

                <b-col cols="4">
                    <b-form-group label="Rol de Usuario" label-for="userRoleSelect">
                    <b-form-select
                        id="userRoleSelect"
                        v-model="user.role"
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
      users: [
        { email: '', role: '', isValid: false } // Initial row
      ],
      roleOptions: ['user-admin', 'ninguno'], // Array of role options
      emailFeedback: 'Ingresa una dirección de correo válida.',
      adminPermittedUsers: [],
    };
  },
  mounted() {
    if(localStorage.getItem('adminPermittedUsers')) {
        this.adminPermittedUsers = JSON.parse(localStorage.getItem('adminPermittedUsers'));
    }
  },
  methods: {
    validateEmail(user, index) {
      this.users.at(index).isValid = user.email.match(/^.+@.+\..+$/i) !== null
    },
    addUser() {
      this.users.push({ email: '', role: '' });
    },
    removeUser(index) {
      if (index > 0) {
        this.users.splice(index, 1);
      }
    },
    triggerLogout() {
      this.$emit('logout-event');
    },
    async getPermitted() {
      const bearerToken = localStorage.getItem('userToken');
      let userToken = null;
      let users = null;
      await fetch(`${this.api_url}/permitted-users`, {
          method: 'GET',
          headers: {
              'Authorization': `${bearerToken}`,
              'Content-Type': 'application/json',
              // You can include additional headers if required
          },
          })
          .then(response => {
              if (!response.ok) {
                  throw new Error('Network response was not ok');
              }
              userToken = response.headers.get('authorization');
              console.log(userToken);//logs the user token
              console.log(response);//logs the response object
              return response.text();
          })
          .then(data => {
              // Handle the response data
              const lines = data.split('\n'); // Split the text into lines

              users = lines.map(line => {
                const values = line.split(' '); // Split each line into values
                const email = values[0]; // First value is the email
          
                // Remaining values are roles, if any
                const roles = values.slice(1).filter(role => role !== '');
          
                return {
                  user_email: email,
                  roles: roles
                };
              });                
              console.log(users);
              this.adminPermittedUsers = users;
              console.log(data);
          })
          .catch(error => {
              // Handle any errors
              console.error('Admin error:', error);
          });
      
      if(userToken===null) {
          console.log("user token is null at this point");
          this.triggerLogout();
      }
      else {
          console.log("user token is not null at this point so we can proceed");
          console.log(users);
          // Store the token and user email in local storage
          localStorage.setItem('userToken', userToken);
          localStorage.setItem('adminPermittedUsers', JSON.stringify(users)); //remember to JSON.parse() it before using to get an object instead
      }
    },
    async insertUsers() {
      // Get list of already existing permitted users.
      await this.getPermitted();
      const permittedUsersList = this.adminPermittedUsers
        .map((user) => {
          const roles = user.roles.length > 0 ? user.roles.join(' ') : '';
          return `${user.user_email} ${roles}`;
        })
        .join('\n');
      // Access the array of users and perform necessary actions
      console.log(permittedUsersList);
      // Get the token for authorization, if it doesn't match the api call won't work
      const bearerToken = localStorage.getItem('userToken');
      // Check if the users array is empty
      if (this.users.length === 0 || bearerToken === undefined) {
        return; // Exit the method without executing further
      }
      // Convert new permitted users array to text file format
      const textFileContent = this.users
        .map((user) => {
          let text = user.email;
          if (user.role === 'user-admin') {
            text += ` ${user.role}`;
          } else if (user.role !== 'ninguno') {
            text += ` ${user.role.join(' ')}`;
          }
          return text;
        })
        .join('\n');
      const combinedTextContent = permittedUsersList + '\n' + textFileContent;
      console.log(combinedTextContent);
      // Create request options
      const requestOptions = {
        method: 'PUT',
        headers: {
          'Authorization': `${bearerToken}`,
          'Content-Type': 'text/plain',
        },
        body: combinedTextContent,
      };

      // Send the PUT request
      try {
        const response = await fetch(`${this.api_url}/permitted-users`, requestOptions);
        // Handle the response as needed
      } catch (error) {
        // Handle error
      }
    },
  },
  computed: {
    isAllValid() {
      return this.users.every(user => user.isValid);
    },
  },
};