export default {
    props: ["mold_control_values"],
    template: `
    <b-container>
        <b-table :items="mold_control_values" :fields="fields" stacked="md" show-empty>
            <template #cell(actions)="row">
                <b-button variant="primary" @click="showModal(row.item)">
                    Editar
                </b-button>
            </template>
        </b-table>

        <b-modal v-model="modalVisible" :title="existingMoldName.replace('.xml', '').toUpperCase()" @ok="triggerUpdateControlValues">
        <b-form @submit.stop.prevent="triggerUpdateControlValues">
            <!-- Form fields go here -->

            <b-form-group label="Número Total de Ciclos Ideal">
                <b-form-input v-model="newNCIdeal" type="number" required></b-form-input>
            </b-form-group>

            <b-form-group label="Número Total de Ciclos Máximo">
                <b-form-input v-model="newNCMax" type="number" required></b-form-input>
            </b-form-group>

            <b-form-group label="Tiempo de Ciclo Ideal">
                <b-form-input v-model.number="newTCIdeal" type="number" step="0.01" required></b-form-input>
            </b-form-group>

            <b-form-group label="Tiempo de Ciclo Máximo">
                <b-form-input v-model.number="newTCMax" type="number" step="0.01" required></b-form-input>
            </b-form-group>
        </b-form>
        </b-modal>
    </b-container>
    `,
    data() {
        return {
            // Control values data
            existingMoldName: "Nombre Molde",
            newNCIdeal: null,
            newNCMax: null,
            newTCIdeal: null,
            newTCMax: null,
            // Modal data
            modalVisible: false,
            // Table data
            fields: [
                { key: "mold_name", label: "Molde" },
                { key: "nc_ideal", label: "N° Ciclos Ideal", variant: 'success' },
                { key: "nc_max", label: "N° Ciclos Max", variant: 'danger' },
                { key: "tc_ideal", label: "Tiempo de Ciclo Ideal (s)", variant: 'success' },
                { key: "tc_max", label: "Tiempo de Ciclo Max (s)", variant: 'danger' },
                { key: "actions", label: "Acciones" }
            ],
        }
    },
    computed: {
        // Control values computed
    },
    methods: {
        // Utility methods
        showModal(item) {
            // Custom logic to handle button click with the selected item
            this.existingMoldName = item.mold_name;
            this.newNCIdeal = item.nc_ideal;
            this.newNCMax = item.nc_max;
            this.newTCIdeal = item.tc_ideal;
            this.newTCMax = item.tc_max;
            this.modalVisible = true;
        },
        hideModal() {
            this.modalVisible = false;
        },
        handleSubmit() {
            // Custom logic to handle form submission
            // ...

            // Close the modal
            this.hideModal();
        },
        // Trigger methods
        triggerUpdateControlValues() {
            const existingMoldName = this.existingMoldName;
            const newNCIdeal = this.newNCIdeal;
            const newNCMax = this.newNCMax;
            const newTCIdeal = this.newTCIdeal;
            const newTCMax = this.newTCMax;
            console.log("triggerUpdateControlValues");
            this.$emit("trigger-updatecontrolvalues", existingMoldName, newNCIdeal, newNCMax, newTCIdeal, newTCMax);
            this.hideModal();
        },
    },
}