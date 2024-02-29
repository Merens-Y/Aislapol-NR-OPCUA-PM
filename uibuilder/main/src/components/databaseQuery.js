/* TODO: Añadir a tabla y CSV:
TODO: Tiempo vapor fijo
TODO: Presión vapor fijo
TODO: Tiempo descarga abierta fijo
TODO: Tiempo vapor movil
TODO: Presión vapor movil
TODO: Tiempo descarga abierta movil
*/
// TODO: Corregir en CSV el formato de la fecha y hora (3 horas adelantado)
// TODO: Corregir Filtro por rango de fechas, considerar revamp de las funciones de filtrado y query.
// TODO: Corregir generación de CSV para parsear json antes.
export default {
    props: ["query_results", "query_options"],
    template: `
        <b-container fluid>
            <!-- Query Selection -->
            <b-row>
                <b-col lg="6" class="my-1">
                    <b-form-group label="Obtener:" label-for="select-query" label-cols-sm="3" label-align-sm="right" label-size="sm" class="mb-0">
                        <b-form-select v-model="selectedQuery" :options="query_options" value-field="value" text-field="label">
                            <template #first>
                                <option value="">-- Seleccionar Query --</option>
                            </template>
                        </b-form-select>
                    </b-form-group>
                </b-col>
                <b-col lg="6" class="my-1"><b-button :disabled="!isValidQuery" @click="makeQuery()">Hacer Query</b-button></b-col>
            </b-row>
            <!-- N number Input -->
            <b-row v-if="selectedQuery === 'GET LAST N' || selectedQuery === 'GET FIRST N'">
                <b-col lg="6" class="my-1">
                    <b-form-group label="N:" label-for="n-for-query" label-cols-sm="3" label-align-sm="right" label-size="sm" class="mb-0">
                        <b-form-input id="n-for-query" type="text" v-model="queryPropN" :state="isInteger(queryPropN)" pattern="[0-9]*"></b-form-input>
                    </b-form-group>
                </b-col>
            </b-row>
            <!-- From and To date range selection -->
            <b-row v-if="selectedQuery === 'GET FROM DATE RANGE' || selectedQuery === 'GET FROM DATE AND TIME RANGE'">
                <b-col lg="6" class="my-1">
                    <b-form-group label="Desde:" label-for="from-date" label-cols-sm="3" label-align-sm="right" label-size="sm" class="mb-0">
                        <b-input-group size="sm">
                            <b-form-datepicker id="from-date" v-model="dateFrom" class="w-75" v-bind="datepickerOptions" :max="dateTo"></b-form-datepicker>
                            <b-button @click="clearFromDate" size="sm" class="w-25">Despejar</b-button>
                        </b-input-group>
                    </b-form-group>
                </b-col>
            </b-row>
            <b-row v-if="selectedQuery === 'GET FROM DATE RANGE' || selectedQuery === 'GET FROM DATE AND TIME RANGE'">
                <b-col lg="6" class="my-1">
                    <b-form-group label="Hasta:" label-for="to-date" label-cols-sm="3" label-align-sm="right" label-size="sm" class="mb-0">
                        <b-input-group size="sm">
                            <b-form-datepicker id="to-date" v-model="dateTo" v-bind="datepickerOptions" :min="dateFrom"></b-form-datepicker>
                            <b-button @click="clearToDate" size="sm" class="w-25">Despejar</b-button>
                        </b-input-group>
                    </b-form-group>
                </b-col>
            </b-row>
            <!-- From and To time range selection -->
            <b-row v-if="selectedQuery === 'GET FROM DATE AND TIME RANGE'">
                <b-col lg="6" class="my-1">
                    <b-form-group label="Desde:" label-for="from-time" label-cols-sm="3" label-align-sm="right" label-size="sm" class="mb-0">
                        <b-input-group size="sm">
                            <b-form-timepicker id="from-time" v-model="timeFrom" class="w-75" v-bind="timepickerOptions"></b-form-timepicker>
                            <b-button @click="clearFromTime" size="sm" class="w-25">Despejar</b-button>
                        </b-input-group>
                    </b-form-group>
                </b-col>
            </b-row>
            <b-row v-if="selectedQuery === 'GET FROM DATE AND TIME RANGE'">
                <b-col lg="6" class="my-1">
                    <b-form-group label="Hasta:" label-for="to-time" label-cols-sm="3" label-align-sm="right" label-size="sm" class="mb-0">
                        <b-input-group size="sm">
                            <b-form-timepicker id="to-time" v-model="timeTo" v-bind="timepickerOptions"></b-form-timepicker>
                            <b-button @click="clearToTime" size="sm" class="w-25">Despejar</b-button>
                        </b-input-group>
                    </b-form-group>
                </b-col>
            </b-row>

            <hr/>
            <b-button :disabled="!canDownloadCSV" @click="downloadCSV" size="lg">
                Descargar 
                <svg class="mt-1 mr-2" xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-filetype-csv" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M14 4.5V14a2 2 0 0 1-2 2h-1v-1h1a1 1 0 0 0 1-1V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4a1 1 0 0 0-1 1v9H2V2a2 2 0 0 1 2-2h5.5L14 4.5ZM3.517 14.841a1.13 1.13 0 0 0 .401.823c.13.108.289.192.478.252.19.061.411.091.665.091.338 0 .624-.053.859-.158.236-.105.416-.252.539-.44.125-.189.187-.408.187-.656 0-.224-.045-.41-.134-.56a1.001 1.001 0 0 0-.375-.357 2.027 2.027 0 0 0-.566-.21l-.621-.144a.97.97 0 0 1-.404-.176.37.37 0 0 1-.144-.299c0-.156.062-.284.185-.384.125-.101.296-.152.512-.152.143 0 .266.023.37.068a.624.624 0 0 1 .246.181.56.56 0 0 1 .12.258h.75a1.092 1.092 0 0 0-.2-.566 1.21 1.21 0 0 0-.5-.41 1.813 1.813 0 0 0-.78-.152c-.293 0-.551.05-.776.15-.225.099-.4.24-.527.421-.127.182-.19.395-.19.639 0 .201.04.376.122.524.082.149.2.27.352.367.152.095.332.167.539.213l.618.144c.207.049.361.113.463.193a.387.387 0 0 1 .152.326.505.505 0 0 1-.085.29.559.559 0 0 1-.255.193c-.111.047-.249.07-.413.07-.117 0-.223-.013-.32-.04a.838.838 0 0 1-.248-.115.578.578 0 0 1-.255-.384h-.765ZM.806 13.693c0-.248.034-.46.102-.633a.868.868 0 0 1 .302-.399.814.814 0 0 1 .475-.137c.15 0 .283.032.398.097a.7.7 0 0 1 .272.26.85.85 0 0 1 .12.381h.765v-.072a1.33 1.33 0 0 0-.466-.964 1.441 1.441 0 0 0-.489-.272 1.838 1.838 0 0 0-.606-.097c-.356 0-.66.074-.911.223-.25.148-.44.359-.572.632-.13.274-.196.6-.196.979v.498c0 .379.064.704.193.976.131.271.322.48.572.626.25.145.554.217.914.217.293 0 .554-.055.785-.164.23-.11.414-.26.55-.454a1.27 1.27 0 0 0 .226-.674v-.076h-.764a.799.799 0 0 1-.118.363.7.7 0 0 1-.272.25.874.874 0 0 1-.401.087.845.845 0 0 1-.478-.132.833.833 0 0 1-.299-.392 1.699 1.699 0 0 1-.102-.627v-.495Zm8.239 2.238h-.953l-1.338-3.999h.917l.896 3.138h.038l.888-3.138h.879l-1.327 4Z"/>
                </svg></b-button>
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
                        debounce="500"
                        ></b-form-input>

                        <b-input-group-append>
                        <b-button :disabled="!filter" @click="filter = null">Despejar</b-button>
                        </b-input-group-append>
                    </b-input-group>
                    </b-form-group>
                </b-col>

                <!-- <b-col lg="6" class="my-1">
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
                        <b-form-checkbox value="machine_serial_number">Máquina</b-form-checkbox>
                        <b-form-checkbox value="mold_recipe_name">Receta</b-form-checkbox>
                    </b-form-checkbox-group>
                    </b-form-group>
                </b-col> -->

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
            stacked="md" show-empty small @filtered="onFiltered" striped empty-text="No hay datos que mostrar">
                <template #cell(actions)="row">
                    <b-button size="sm" :variant="row.item.is_maintenance ? 'primary' : 'outline-success'" @click="triggerMaintenanceToggle(row.item.cycle_id)" class="mr-1">
                    Es {{ row.item.is_maintenance ? 'Ciclo Normal' : 'Mantenimiento' }}
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
                { key: 'cycle_id', label: '#', sortable: true, sortDirection: 'desc', class: 'text-center' },
                { key: 'machine_serial_number', label: 'Número de Serie', sortable: true, sortDirection: 'desc', class: 'text-center' },
                {
                    key: 'mold_recipe_name',
                    label: 'Receta',
                    formatter: (value) => {
                        if (value.includes('.xml')) {
                            return value.replace('.xml', '').toUpperCase();
                        } else {
                            return value.toUpperCase();
                        }
                    },
                    sortable: true,
                    sortDirection: 'desc',
                    sortByFormatted: true,
                    filterByFormatted: true,
                    class: 'text-center'
                },
                { key: 'cycle_number', label: 'Número de Ciclo', sortable: true, class: 'text-center' },
                { key: 'cycle_time', label: 'Tiempo de Ciclo (s)',
                    formatter: (value) => {
                            // convert cycle time from miliseconds to seconds with two decimal places
                            return (value / 1000).toFixed(2);
                        },
                    sortable: true, class: 'text-center' },
                { key: 'time_stamp', label: 'Marca de Tiempo', formatter: 'formatTime', sortable: true, class: 'text-center' },
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
            dateFrom: '',
            dateTo: '',
            datepickerOptions: {
                'label-next-month': 'Mes Siguiente',
                'label-next-year': 'Año Siguiente',
                'label-current-month': 'Current Mes',
                'label-prev-month': 'Mes Anterior',
                'label-prev-year': 'Año Anterior',
                'label-help': 'Usa las teclas para navegar entre días',
                'label-no-date-selected': "Selecciona una fecha",
                'locale': "es",
                'startWeekday': "1",
            },
            timeTo: '',
            timeFrom: '',
            timepickerOptions: {
                'locale': "es",
                'label-close-button': "Cerrar",
                'label-decrement': "Reducir",
                'label-increment': "Incrementar",
                'label-hours': "Horas",
                'label-minutes': "Minutos",
                'label-seconds': "Segundos",
                'label-no-time-selected': "Selecciona una hora",
                'label-now-button': "Ahora",
                'label-reset-button': "Reiniciar",
                'reset-button': true,
            },
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
        canDownloadCSV() {
            return this.query_results.length !== 0; // Modify the condition based on your validity criteria
        },
    },
    updated() {
        // Set the initial number of items
        const filteredItems = this.filterData();
        this.totalRows = filteredItems.length;
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
        onFiltered() {
            // Trigger pagination to update the number of buttons/pages due to filtering
            const filteredItems = this.filterData()
            if (filteredItems.length === 0) {
                this.currentPage = 1;
                this.totalRows = 1;
                return;
            }
            else {
                this.totalRows = filteredItems.length;
                this.currentPage = 1;
            }
        },
        clearFromDate() {
            this.dateFrom = '';
        },
        clearToDate() {
            this.dateTo = '';
        },
        clearToTime() {
            this.timeTo = '';
        },
        clearFromTime() {
            this.timeFrom = '';
        },
        // methods for CSV export.
        filterData() {
            // Always stringify the recipe_details
            const dataWithRecipeDetailsStringified = this.query_results.map(row => {
                if (row.recipe_details) {
                    // Stringify the recipe_details
                    row.recipe_details = JSON.stringify(row.recipe_details);
                }
                return row;
            });
            console.log('Data after stringifying recipe_details:', dataWithRecipeDetailsStringified);

            // Apply filtering based on specific criteria
            if (this.filter === '' || this.filter === null) {
                return dataWithRecipeDetailsStringified;
            }
            else {
                const filteredData = dataWithRecipeDetailsStringified.filter((row) => {
                    const { name, id } = row;
                    const filterName = this.filterOn.includes('machine_serial_number') || false;
                    const filterRecipe = this.filterOn.includes('mold_recipe_name') || false;
                    const nameMatch = filterName && name.toLowerCase().includes(this.filter.toLowerCase());
                    const idMatch = filterRecipe && id.toLowerCase().includes(this.filter.toLowerCase());

                    if (filterName && filterRecipe) {
                        return nameMatch || idMatch;
                    } else if (filterName) {
                        return nameMatch;
                    } else if (filterRecipe) {
                        return idMatch;
                    } else {
                        // If no specific filtering is enabled, search in all fields
                        const values = Object.values(row).join('').toLowerCase();
                        return values.includes(this.filter.toLowerCase());
                    }
                });
                console.log('Data after applying filters:', filteredData);

                return filteredData;
            }
        },
        generateCSV() {
            const filteredData = this.filterData(); // Apply filtering based on specific criteria
            const header = Object.keys(filteredData[0]).join(',');
            const rows = filteredData.map((row) => Object.values(row).join(','));
            return [header, ...rows].join('\n');
        },
        downloadCSV() {
            const csvContent = this.generateCSV();
            const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
            const downloadLink = document.createElement('a');
            const url = URL.createObjectURL(blob);
            downloadLink.href = url;
            downloadLink.setAttribute('download', 'data.csv');
            document.body.appendChild(downloadLink);
            downloadLink.click();
            document.body.removeChild(downloadLink);
            URL.revokeObjectURL(url);
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
            else if (this.selectedQuery === 'GET FIRST HUNDRED') {
                this.queryPropN = 100;
                this.triggerFirstNQuery();
                return;
            }
            else if (this.selectedQuery === 'GET FIRST N') {
                this.triggerFirstNQuery();
                return;
            }
            else if (this.selectedQuery === 'GET FROM DATE RANGE') {
                this.triggerDateRangeQuery();
                return;
            }
            else if (this.selectedQuery === 'GET FROM DATE AND TIME RANGE') {
                this.triggerDateTimeRangeQuery();
                return;
            }
        },
        // methods for the triggering of methods in the parent component.
        triggerLastNQuery() {
            const n = this.queryPropN;
            this.$emit('lastn-event', n);
        },
        triggerFirstNQuery() {
            const n = this.queryPropN;
            this.$emit('firstn-event', n);
        },
        triggerDateRangeQuery() {
            const dateFrom = String(this.dateFrom);
            const dateTo = String(this.dateTo);
            this.$emit('daterange-event', dateFrom, dateTo);
        },
        triggerDateTimeRangeQuery() {
            const dateFrom = String(this.dateFrom);
            const dateTo = String(this.dateTo);
            const timeFrom = String(this.timeFrom);
            const timeTo = String(this.timeTo);
            const timeWithTZFrom = `${dateFrom} ${timeFrom}`;
            const timeWithTZTo = `${dateTo} ${timeTo}`;
            this.$emit('datetimerange-event', dateFrom, dateTo, timeWithTZFrom, timeWithTZTo);
        },
        triggerMaintenanceToggle(row_id) {
            const id = row_id;
            this.$emit('maintenance-toggle-event', id);
            setTimeout(this.makeQuery, 200);
        },
    },
}