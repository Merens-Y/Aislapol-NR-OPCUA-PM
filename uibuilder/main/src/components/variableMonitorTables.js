export default {
    props: ['table_data', 'recipe_data'],
    template: `
    <b-container fluid>
        <b-row>
            <b-col lg="7" my="1">
                <b-table :items="table_data" :fields="tableFields" caption-top small striped>
                    <template #table-caption>PRODUCCIÓN DESDE MANTENIMIENTO</template>
                    <template v-slot:cell(machine_name)="row">
                        {{ row.item.machine_name }}
                    </template>
                    <template v-slot:cell(recipe_counts)="row">
                        <div v-for="(value, recipe) in row.item.recipe_counts" :key="recipe">
                        <template v-if="value > 0">
                            <div>{{ recipe }}</div>
                        </template>
                        </div>
                    </template>
                    <template v-slot:cell(produced)="row">
                        <div v-for="(value, recipe) in row.item.recipe_counts" :key="recipe">
                        <template v-if="value > 0">
                            <div>{{ value }}</div>
                        </template>
                        </div>
                    </template>
                </b-table>
            </b-col>
            <b-col lg="5" my="1">
                <b-table :items="recipe_data" :fields="recipeFields" caption-top small striped>
                    <template #table-caption>PRODUCCIÓN ÚLTIMAS 24HRS</template>
                    <template v-slot:cell(recipe)="row">
                        {{ row.item.recipe }}
                    </template>
                    <template v-slot:cell(total)="row">
                        {{ row.item.total }}
                    </template>
                </b-table>
            </b-col>
        </b-row>
    </b-container>
`,
    data() {
        return {
            tableFields: [
                { key: 'machine_name', label: 'MAQ', sortable: false, sortDirection: 'desc', class: 'text-center' },
                { key: 'recipe_counts', label: 'MOLDE', sortable: false, sortDirection: 'desc', class: 'text-left' },
                { key: 'produced', label: 'PROD', sortable: false, sortDirection: 'desc', class: 'text-right' },
            ],
            recipeFields: [
                { key: 'recipe', label: 'MOLDE', sortable: false, sortDirection: 'desc', class: 'text-left' },
                { key: 'total', label: 'PRODUCIDO', sortable: false, sortDirection: 'desc', class: 'text-right' },
            ],
        };
    },
    methods: {
    },
}