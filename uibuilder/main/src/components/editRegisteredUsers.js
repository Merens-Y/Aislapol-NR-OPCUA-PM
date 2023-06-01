export default {
    props: ['admin_registered_users', 'admin_permitted_users'],
    watch: {
        admin_registered_users(newVal) {
            // Perform actions when the prop value changes
            this.registered_users_table = this.convertRUtoRUTable(newVal);
        },
    },
    template: `
    <b-container>
        <b-row>
        <h1>Eliminar Usuario Registrado</h1>
            <b-table :items="registered_users_table" stacked="md" show-empty small striped hover caption-top :fields="aPUFields">
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
                <b-button size="sm" variant="danger" @click="triggerDeleteUser(row.item.user_email)">
                    <b-icon icon="person-dash" aria-hidden="true"></b-icon>
                    Borrar
                </b-button>
                </template>
            </b-table>
        </b-row>
    </b-container>
    `,
    data() {
        return {
            // Add reactive data variables here
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
            registered_users_table: [],
        }
    }, // --- End of data --- //
    computed: {},
    methods: {
        // from here on are trigger to methods defined in the main Vue instance (index.js).
        triggerDeleteUser(user_id) {
            const userToDelete = user_id;
            this.$emit('deluser-event', userToDelete)
        },
        triggerGetPU() {
            this.$emit('getpu-event')
        },
        triggerGetRU() {
            this.$emit('getru-event')
        },
        // from here on are methods unique to this component.
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
    }, // --- End of methods --- //

    // Available hooks: beforeCreate,created,beforeMount,mounted,beforeUpdate,updated,beforeDestroy,destroyed, activated,deactivated, errorCaptured
    mounted() {
        if (this.admin_registered_users) {
            this.registered_users_table = this.convertRUtoRUTable(this.admin_registered_users);
        }
    },
}