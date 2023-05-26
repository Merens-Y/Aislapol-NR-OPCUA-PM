// TODO: logic and api call for changing user role.
export default {
    props: ['admin_registered_users'],
    watch: {
        admin_registered_users(newVal) {
            // Perform actions when the prop value changes
            this.registered_users_table = this.convertRUtoRUTable(newVal);
        },
    },
    // Component options: template, data, methods, etc.
    template: `
    <b-col>
        <b-table :items="registered_users_table" stacked="md" show-empty small striped hover caption-top :fields="aRUFields">
            <template #table-caption>Lista de usuarios registrados en la aplicación.</template>
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
            <b-button size="sm" variant="primary">
                <b-icon icon="pencil-square" aria-hidden="true"></b-icon>
                Cambiar Rol
            </b-button>
            </template>
        </b-table>
    </b-col>
    `,
    data() {
        return {
            // Add reactive data variables here
            aRUFields: [
                // A virtual column that doesn't exist in items
                { key: 'index', label: '#' },
                // A column that needs custom formatting
                { key: 'user_email', label: 'Usuario' },
                // A regular column
                'roles',
                // A regular column
                'acciones'
            ],
            registered_users_table: [],
        }
    },
    methods: {
        // here are methods that are only used in this component
        convertRUtoRUTable(usersObject) {
            // Convert the array of registered users into a table array for display.
            const usersArray = Object.entries(usersObject).map(([email, user]) => {
                const userRoles = user.Roles || [];
                return {
                    user_email: email,
                    roles: userRoles,
                };
            });
            return usersArray;
        },
        // from here on are trigger to methods defined in the main Vue instance (index.js).
    },
    mounted() {
        if (this.admin_registered_users) {
            this.registered_users_table = this.convertRUtoRUTable(this.admin_registered_users);
        }
    },
}
