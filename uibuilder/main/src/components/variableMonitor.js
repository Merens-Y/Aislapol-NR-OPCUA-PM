// TODO: Definir graficos de control para cada maquina y tablas de control para cada maquina
export default {
    props: ['chart_data'],
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
                    defaultLocale: 'es',
                    locales: [{
                        name: 'es',
                        options: {
                            // months: ['January', 'February', 'March', 'April', 'Mayo', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                            // same months but in spanish:
                            months: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Setiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                            shortMonths: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Set', 'Oct', 'Nov', 'Dic'],
                            days: ['Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado'],
                            shortDays: ['Dom', 'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab'],
                            toolbar: {
                                download: 'Descargar SVG',
                                selection: 'Seleccion',
                                selectionZoom: 'Seleccionar Zoom',
                                zoomIn: 'Acercar',
                                zoomOut: 'Alejar',
                                pan: 'Mover',
                                reset: 'Reiniciar Zoom',
                            },
                        }
                    }],
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
                    tickAmount: 8,
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
                stroke: {
                    width: 3, // Set the desired width of the line here
                },
                tooltip: {
                    enabled: true,
                    x: {
                        show: true,
                        format: 'dd MMMM, HH:mm',
                        formatter: undefined,
                    },
                },
                title: {
                    text: "MAQ-15",
                    align: 'left',
                    margin: 10,
                    offsetX: 0,
                    offsetY: 0,
                    floating: false,
                    style: {
                        fontSize: '14px',
                        fontWeight: 'bold',
                        fontFamily: undefined,
                        color: '#FFFFFF'
                    },
                },
            },
            chartSeries: [
                {
                    name: 'Tiempo de Ciclo',
                    data: this.processChartData(this.chart_data),
                },
            ],
        };
    },
    methods: {
        generateData(unused) {
            const data = [];
            const currentTime = new Date().getTime();
            const interval = 24 * 60 * 60 * 1000 / 100;

            for (let i = 0; i < 100; i++) {
                const timestamp = currentTime - i * interval;
                const value = Math.random() * 50 + 70;
                data.push({ x: timestamp, y: value });
            }
            console.log(data);
            return data.reverse();
        },
        timestampFromDateTime(actualDate, actualTime) {
            const date = actualDate;
            const time = actualTime;

            // Parse the date and time strings
            const year = parseInt(date.substr(0, 4));
            const month = parseInt(date.substr(5, 2)) - 1; // Months are zero-based in JavaScript Date
            const day = parseInt(date.substr(8, 2));
            const hour = parseInt(time.substr(0, 2));
            const minute = parseInt(time.substr(3, 2));
            const second = parseInt(time.substr(6, 2));

            // Create a new Date object using the parsed components
            const timestamp = new Date(year, month, day, hour, minute, second).getTime();
            return timestamp;
        },
        processChartData(data) {
            const series = []; // Array to store the data series

            // Process each data object
            data.forEach((item) => {
                const timestamp = this.timestampFromDateTime(item.date, item.timestamp); // Convert timestamp to milliseconds
                const cycleTime = item.cycle_time;

                // Add data point for cycle time
                series.push({
                    x: timestamp,
                    y: cycleTime,
                });
            });
            console.log(series);
            return series.reverse();
        },
    },
};