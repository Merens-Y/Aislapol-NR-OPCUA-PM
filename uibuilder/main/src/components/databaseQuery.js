export default {
    props: ["query_results", "query_options"],
    template: `
        <b-container fluid>
            <b-row>
            <b-col lg="6" class="my-1">
                <b-form-select v-model="selectedQuery" :options="query_options" value-field="value" text-field="label">
                    <template #first>
                        <option value="">-- Seleccionar Query --</option>
                    </template>
                </b-form-select>
            </b-col>
            <b-col lg="6" class="my-1"><b-button :disabled="!isValidQuery" @click="makeQuery(selectedQuery)">Hacer Query</b-button></b-col>
            </b-row>
            <b-row v-if="selectedQuery === 'GET LAST N'">
                <b-col lg="6" class="my-1">
                    <b-form-input id="n-for-query" type="text" v-model="queryPropN" :state="isInteger(queryPropN)" pattern="[0-9]*"></b-form-input>
                </b-col>
            </b-row>
            <hr/>
            <!-- User Interface controls -->
            <b-row>
                <b-col lg="6" class="my-1">
                    <b-form-group label="Ordenar"
                    label-for="sort-by-select"
                    label-cols-sm="3"
                    label-align-sm="right"
                    label-size="sm"
                    class="mb-0"
                    v-slot="{ ariaDescribedby }"
                    >
                        <b-input-group size="sm">
                            <b-form-select
                            id="sort-by-select"
                            v-model="sortBy"
                            :options="sortOptions"
                            :aria-describedby="ariaDescribedby"
                            class="w-75"
                            >
                            <template #first>
                                <option value="">-- ninguno --</option>
                            </template>
                            </b-form-select>

                            <b-form-select
                            v-model="sortDesc"
                            :disabled="!sortBy"
                            :aria-describedby="ariaDescribedby"
                            size="sm"
                            class="w-25"
                            >
                            <option :value="false">Asc</option>
                            <option :value="true">Desc</option>
                            </b-form-select>
                        </b-input-group>
                    </b-form-group>
                </b-col>

                <b-col lg="6" class="my-1">
                    <b-form-group
                    label="Orden inicial"
                    label-for="initial-sort-select"
                    label-cols-sm="3"
                    label-align-sm="right"
                    label-size="sm"
                    class="mb-0"
                    >
                    <b-form-select
                        id="initial-sort-select"
                        v-model="sortDirection"
                        :options="['asc', 'desc', 'last']"
                        size="sm"
                    ></b-form-select>
                    </b-form-group>
                </b-col>

                <b-col lg="6" class="my-1">
                    <b-form-group
                    label="Filtrar"
                    label-for="filter-input"
                    label-cols-sm="3"
                    label-align-sm="right"
                    label-size="sm"
                    class="mb-0"
                    >
                    <b-input-group size="sm">
                        <b-form-input
                        id="filter-input"
                        v-model="filter"
                        type="search"
                        placeholder="Escribe algo para buscar"
                        ></b-form-input>

                        <b-input-group-append>
                        <b-button :disabled="!filter" @click="filter = ''">Despejar</b-button>
                        </b-input-group-append>
                    </b-input-group>
                    </b-form-group>
                </b-col>

                <b-col lg="6" class="my-1">
                    <b-form-group
                    v-model="sortDirection"
                    label="Filtrar por"
                    description="Deja todo sin marcar para buscar en todos los campos."
                    label-cols-sm="3"
                    label-align-sm="right"
                    label-size="sm"
                    class="mb-0"
                    v-slot="{ ariaDescribedby }"
                    >
                    <b-form-checkbox-group
                        v-model="filterOn"
                        :aria-describedby="ariaDescribedby"
                        class="mt-1"
                    >
                        <b-form-checkbox value="machine_name">Máquina</b-form-checkbox>
                        <b-form-checkbox value="recipe_name">Receta</b-form-checkbox>
                    </b-form-checkbox-group>
                    </b-form-group>
                </b-col>

                <b-col sm="5" md="6" class="my-1">
                    <b-form-group
                    label="Por página"
                    label-for="per-page-select"
                    label-cols-sm="6"
                    label-cols-md="4"
                    label-cols-lg="3"
                    label-align-sm="right"
                    label-size="sm"
                    class="mb-0"
                    >
                    <b-form-select
                        id="per-page-select"
                        v-model="perPage"
                        :options="pageOptions"
                        size="sm"
                    ></b-form-select>
                    </b-form-group>
                </b-col>

                <b-col sm="7" md="6" class="my-1">
                    <b-pagination
                    v-model="currentPage"
                    :total-rows="totalRows"
                    :per-page="perPage"
                    align="fill"
                    size="sm"
                    class="my-0"
                    ></b-pagination>
                </b-col>
            </b-row>

            <!-- Main table element -->
            <b-table :items="query_results" :fields="fields" :current-page="currentPage" :per-page="perPage" :filter="filter"
            :filter-included-fields="filterOn" :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection"
            stacked="md" show-empty small @filtered="onFiltered" empty-text="No hay datos que mostrar">
                <template #cell(actions)="row">
                    <b-button size="sm" @click="info(row.item, row.index, $event.target)" class="mr-1">
                    Info modal
                    </b-button>
                    <b-button size="sm" @click="row.toggleDetails">
                    {{ row.detailsShowing ? 'Esconder' : 'Mostrar' }} Detalles
                    </b-button>
                </template>

                <template #row-details="row">
                    <b-card>
                    <ul>
                        <li v-for="(value, key) in row.item" :key="key">{{ key }}: {{ value }}</li>
                    </ul>
                    </b-card>
                </template>
            </b-table>

            <!-- Info modal -->
            <b-modal :id="infoModal.id" :title="infoModal.title" ok-only @hide="resetInfoModal">
            <pre>{{ infoModal.content }}</pre>
            </b-modal>
        </b-container>
    `,
    data() {
        return {
            fields: [
                { key: 'ID', label: '#', sortable: true, sortDirection: 'desc', class: 'text-center' },
                { key: 'machine_name', label: 'Nombre Máquina', sortable: true, sortDirection: 'desc', class: 'text-center' },
                {
                    key: 'recipe_name',
                    label: 'Receta',
                    formatter: (value) => {
                        if (value === '35lbs prueb.xml') {
                            return '35lbs Mix';
                        } else {
                            return 'Otro';
                        }
                    },
                    sortable: true,
                    sortDirection: 'desc',
                    sortByFormatted: true,
                    filterByFormatted: true,
                    class: 'text-center'
                },
                { key: 'cycle', label: 'Número de Ciclo', sortable: true, class: 'text-center' },
                { key: 'cycle_time', label: 'Tiempo de Ciclo', sortable: true, class: 'text-center' },
                { key: 'date', label: 'Fecha', formatter: 'formatDate', sortable: true, class: 'text-center' },
                { key: 'timestamp', label: 'Hora', formatter: 'formatTime', sortable: true, class: 'text-center' },
                { key: 'actions', label: 'Acciones' }
            ],
            totalRows: 1,
            currentPage: 1,
            perPage: 5,
            pageOptions: [5, 10, 15, { value: 50, text: "Max" }],
            sortBy: '',
            sortDesc: false,
            sortDirection: 'asc',
            filter: null,
            filterOn: [],
            infoModal: {
                id: 'info-modal',
                title: '',
                content: ''
            },
            selectedQuery: '',
            queryPropN: 100,
        }
    },
    computed: {
        sortOptions() {
            // Create an options list from our fields
            return this.fields
                .filter(f => f.sortable)
                .map(f => {
                    return { text: f.label, value: f.key };
                })
        },
        isValidQuery() {
            return this.selectedQuery !== ''; // Modify the condition based on your validity criteria
        },
    },
    updated() {
        // Set the initial number of items
        this.totalRows = this.query_results.length;
    },
    methods: {
        // methods for the table component.
        isInteger(value) {
            const actualNumber = Number(value);
            return (Number.isInteger(actualNumber) && (actualNumber > 0));
        },
        formatTime(timeString) {
            const timeParts = timeString.split('.');
            const time = timeParts[0];
            return time;
        },
        formatDate(dateString) {
            const date = new Date(dateString);
            const day = date.getDate().toString().padStart(2, '0');
            const month = (date.getMonth() + 1).toString().padStart(2, '0');
            const year = date.getFullYear().toString();

            return `${day}-${month}-${year}`;
        },
        info(item, index, button) {
            this.infoModal.title = `Row index: ${index}`;
            this.infoModal.content = JSON.stringify(item, null, 2);
            this.$root.$emit('bv::show::modal', this.infoModal.id, button);
        },
        resetInfoModal() {
            this.infoModal.title = '';
            this.infoModal.content = '';
        },
        onFiltered(filteredItems) {
            // Trigger pagination to update the number of buttons/pages due to filtering
            this.totalRows = filteredItems.length;
            this.currentPage = 1;
        },
        // methods for the query component.
        makeQuery() {
            if (this.selectedQuery === 'GET LAST HUNDRED') {
                this.queryPropN = 100;
                this.triggerLastNQuery();
                return;
            }
            else if (this.selectedQuery === 'GET LAST N') {
                this.triggerLastNQuery();
                return;
            }
        },
        // methods for the triggering of methods in the parent component.
        triggerLastNQuery() {
            const n = this.queryPropN;
            this.$emit('lastn-event', n);
        }
    }
}