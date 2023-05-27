// TODO: IMPORTANTE: Definir graficos de control para cada maquina

export default {
    props: [''],
    template: `
    <b-container fluid>
        <b-row>
            <b-col lg="12" my="1"><apexchart :options="chartOptions" :series="chartSeries" type="line" height="200" /></b-col>
            <b-col lg="12" my="1"><apexchart :options="chartOptions" :series="chartSeries" type="line" height="200" /></b-col>
            <b-col lg="12" my="1"><apexchart :options="chartOptions" :series="chartSeries" type="line" height="200" /></b-col>
        </b-row>
    </b-container>
    `,
    data() {
        return {
            chartOptions: {
                chart: {
                    toolbar: {
                        show: false,
                    },
                },
                colors: ['#00FF00'], // Set the color of the line to a highly luminous green
                theme: {
                    mode: 'dark', // Set the theme mode to 'dark' for a black background
                    palette: 'palette10', // Use the 'palette10' color palette for vibrant colors
                },
                xaxis: {
                    type: 'datetime',
                    labels: {
                        datetimeFormatter: {
                            year: 'yyyy',
                            month: 'MMM',
                            day: 'dd',
                            hour: 'HH:mm:ss',
                        },
                        style: {
                            colors: '#FFFFFF', // Set the color of x-axis labels to white
                        },
                    },
                },
                yaxis: {
                    min: 50,
                    max: 150,
                    tickAmount: 6,
                    labels: {
                        formatter: function (value) {
                            return value.toFixed(2);
                        },
                        style: {
                            colors: '#FFFFFF', // Set the color of y-axis labels to white
                        },
                    },
                },
                annotations: {
                    yaxis: [
                        {
                            y: 100,
                            borderColor: '#FEB019',
                            borderWidth: 5,
                            label: {
                                borderColor: '#FEB019',
                                style: {
                                    color: '#FFFFFF', // Set the color of the annotation label to white
                                    background: '#FEB019',
                                },
                                text: 'Y = 100',
                            },
                        },
                        {
                            y: 120,
                            borderColor: '#FF4560',
                            borderWidth: 5,
                            label: {
                                borderColor: '#FF4560',
                                style: {
                                    color: '#FFFFFF', // Set the color of the annotation label to white
                                    background: '#FF4560',
                                },
                                text: 'Y = 120',
                            },
                        },
                    ],
                },
            },
            chartSeries: [
                {
                    name: 'Cycle Time',
                    data: this.generateData(),
                },
            ],
        };
    },
    methods: {
        generateData() {
            const data = [];
            const currentTime = new Date().getTime();
            const interval = 24 * 60 * 60 * 1000 / 100;

            for (let i = 0; i < 100; i++) {
                const timestamp = currentTime - i * interval;
                const value = Math.random() * 50 + 70;
                data.push({ x: timestamp, y: value });
            }

            return data.reverse();
        },
    },
};