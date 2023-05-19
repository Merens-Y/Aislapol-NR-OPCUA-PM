export default {
    props: ['admin_permitted_users'],
    template: `
    <div>
        <b-button @click="toggleEdit" v-if="!showEditTable" variant="success">Edit</b-button>
        <b-button @click="finishEdit" v-if="showEditTable" variant="outline-primary">Finish Edit</b-button>
        <b-button @click="cancelEdit" v-if="showEditTable" variant="danger">Cancel</b-button>
        
        <b-table v-if="!showEditTable" :items="admin_permitted_users" small striped hover caption-top :fields="fields">
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
        </b-table>
        
        <b-table v-if="showEditTable" :items="edit_permitted_users" small striped hover caption-top :fields="fieldsWithDeleteColumn">
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
            <b-button variant="danger" @click="deleteRow(row.index)">
                <b-icon icon="trash-fill" aria-hidden="true"></b-icon>
                Borrar
            </b-button>
            </template>
        </b-table>
    </div>
    `,
    data() {
        return {
            showEditTable: false,
            edit_permitted_users: [], // Array for editing

            fields: [
                // A virtual column that doesn't exist in items
                { key: 'index', label: '#' },
                // A column that needs custom formatting
                { key: 'user_email', label: 'Usuario' },
                // A regular column
                'roles'
            ], // Fields for the original table
            fieldsWithDeleteColumn: [
                // A virtual column that doesn't exist in items
                { key: 'index', label: '#' },
                // A column that needs custom formatting
                { key: 'user_email', label: 'Usuario' },
                // A regular column
                'roles',
                // A regular column
                'acciones'
            ], // Fields for the edit table with an additional delete column
        };
    },
    methods: {
        toggleEdit() {
            this.showEditTable = true;
            this.edit_permitted_users = [...this.admin_permitted_users];
        },
        finishEdit() {
            this.showEditTable = false;
            this.triggerUpdateAdminUsers(this.edit_permitted_users);
            this.edit_permitted_users = [];
        },
        triggerUpdateAdminUsers(updatedUsers) {
            const usersArray = updatedUsers;
            this.$emit('updateusers-event', updatedUsers);
        },
        cancelEdit() {
            this.showEditTable = false;
            this.edit_permitted_users = [];
        },
        deleteRow(index) {
            this.edit_permitted_users.splice(index, 1);
        }
    }
}