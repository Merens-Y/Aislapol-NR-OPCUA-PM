export default {
    props: ['admin_permitted_users'],
    template: `
    <b-row>
        <b-button variant="outline-info" @click="triggerGetPU">Refrescar lista de Usuarios Permitidos</b-button>
        <b-button variant="outline-info" @click="triggerGetRU">Refrescar lista de Usuarios Registrados</b-button>
        <div class="w-100"></div>
        <div>
        <b-table :items="admin_permitted_users" small striped hover caption-top :fields="aPUFields">
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
            <b-button variant="danger" @click="triggerDeleteUser(row.item.user_email)">
                <b-icon icon="trash-fill" aria-hidden="true"></b-icon>
                Borrar
            </b-button>
            </template>
        </b-table>
        </div>
    </b-row>
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
        }
    }, // --- End of data --- //
    mounted() { },
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
    }, // --- End of methods --- //

    // Available hooks: beforeCreate,created,beforeMount,mounted,beforeUpdate,updated,beforeDestroy,destroyed, activated,deactivated, errorCaptured
}