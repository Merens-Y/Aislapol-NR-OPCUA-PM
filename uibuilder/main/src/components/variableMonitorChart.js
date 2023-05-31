// TODO: Hacer el gráfico dinámico mediante variables dinámicas de vue.js
export default {
    props: ['chart_data', 'chart_options'],
    template: `
    <b-container fluid>
        <b-row>
            <b-col lg="12" my="1" v-for="(chart, index) in chart_data"><apexchart :options="chart_options[index].temp_options" :series="chart" type="line" height="200" /></b-col>
        </b-row>
    </b-container>
    `,
    data() {
        return {};
    },
    methods: {},
};