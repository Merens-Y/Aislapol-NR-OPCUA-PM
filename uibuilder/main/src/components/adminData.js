//http://127.0.0.1:1880 for localhost, must define for later stages of developent.
// const api_url = 'http://192.168.1.104:1880';
export default {
    props: ['api_url'],
    template: `
    <div>
        <b-button variant="outline-info" @click="getPermitted">Mostrar Datos de Usuarios</b-button>
        <div>
        <b-table :items="adminPermittedUsers" small striped hover caption-top :fields="aPUFields">
            <template #table-caption>Lista de usuarios permitidos en la aplicación.</template>
            <template #cell(index)="row">
            {{ row.index + 1 }}
            </template>
            <template v-slot:cell(user_email)="row">
            {{ row.value }}
            </template>
            <template v-slot:cell(roles)="row">
            {{ row.value.length > 0 ? row.value.join(', ') : 'Sin rol' }}
            </template>
            <template v-slot:cell(acciones)="row">
            <b-button variant="danger" @click="deleteUser(row.item.user_email)">
                <b-icon icon="trash-fill" aria-hidden="true"></b-icon>
                Borrar
            </b-button>
            </template>
        </b-table>
        </div>
    </div>
    `,
    data() { return {
        // Add reactive data variables here
        adminPermittedUsers: [],
        aPUFields: [
            // A virtual column that doesn't exist in items
            { key: 'index', label: '#' },
            // A column that needs custom formatting
            { key: 'user_email', label: 'Usuario' },
            // A regular column
            'roles',
            // A regular column
            'acciones'
          ],
    } }, // --- End of data --- //
    mounted() {
        if(localStorage.getItem('adminPermittedUsers')) {
            this.adminPermittedUsers = JSON.parse(localStorage.getItem('adminPermittedUsers'));
        }
    },
    computed: {},

    methods: {
        deleteUser(user_id) {
            console.log(user_id);
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
    }, // --- End of methods --- //

    // Available hooks: beforeCreate,created,beforeMount,mounted,beforeUpdate,updated,beforeDestroy,destroyed, activated,deactivated, errorCaptured
}