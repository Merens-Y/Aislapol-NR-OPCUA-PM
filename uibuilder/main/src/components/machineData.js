// TODO: Set up a way to make the cards bigger on click, by setting the class col-lg-12 to the card that was clicked and make appear a button to go back to the original state.
export default {
    props: ['pre_exp_arr', 'mold_arr'],
    template: `
    <b-container>
        <b-tabs content-class="mt-3" align="center">
            <b-tab title="Estado de Maquinarias" active>
                <div>{{ cacheReplay() }}</div>
                    <div class="row">
                        
                            <b-card class="col-12 col-lg-5 col-xl-4 p-1 m-1" v-for="pre_exp in pre_exp_arr" v-bind:class="[pre_exp.estado.texto]">
                                <div class="row">
                                    <p class="col p-1 m-1">Pre-Expansor {{pre_exp.numero}}</p> <div class="col-" v-bind:class="[pre_exp.estado.led]"></div>
                                    <div class="w-100"></div>
                                    <div class="col-sm"><p><b>Material:</b></p></div>                                
                                    <div class="col-md value-field text-center">{{pre_exp.material}}</div>
                                    <div class="w-100"></div>
                                    <div class="col-sm"><p><b>Kg Procesados:</b></p></div>                                
                                    <div class="col-md value-field text-center">{{pre_exp.kilog}}</div>
                                    <div class="w-100"></div>
                                    <div class="col-sm"><p><b>Tiempo:</b></p></div>                                
                                    <div class="col-md value-field text-center">{{pre_exp.tiempo}}</div>
                                    <div class="w-100"></div>
                                    <div class="col-sm"><p><b>Densidad:</b></p></div>                                
                                    <b-col class="col-md value-field text-center">
                                        <b-row class="no-gutters">
                                            <div class="col">{{pre_exp.densidad.min}}<br>min</div>
                                            <div class="col">{{pre_exp.densidad.avg}}<br>prom</div>
                                            <div class="col">{{pre_exp.densidad.max}}<br>max</div>
                                        </b-row>
                                    </b-col>
                                    <div class="w-100"></div>
                                    <b-col class="p-3"></b-col> 
                                </div>
                            </b-card>
                            <b-card class="col-12 col-md-5 col-lg-3 p-1 m-1" v-for="mold in mold_arr" v-bind:class="[mold.estado.texto]">
                                <div class="row">
                                    <p class="col p-1 m-1">Moldeador {{mold.numero}}</p> <div class="col-" v-bind:class="[mold.estado.led]"></div>
                                    <div class="w-100"></div>
                                    <div class="col-sm"><p><b>Molde:</b></p></div>
                                    <div class="col-md value-field text-center">{{mold.molde}}</div>
                                    <div class="w-100"></div>
                                    <div class="col-sm"><p><b>Ciclos por Hora:</b></p></div>
                                    <div class="col-md value-field text-center">{{mold.ciclos_hora}}</div>
                                    <div class="w-100"></div>
                                    <div class="col-sm"><p><b>Tiempo de Ciclo:</b></p></div>
                                    <div class="col-md value-field text-center">{{mold.tiempo_ciclo}}</div>
                                    <div class="w-100"></div>
                                    <div class="col-sm"><p><b>Total de ciclos:</b></p></div>
                                    <div class="col-md value-field text-center">{{mold.ciclos_total}}</div>                                                       
                                </div>
                            </b-card>
                        
                    </div>
            </b-tab>
            <b-tab title="Base de Datos">
                <b-form-input id="type-search" placeholder="Ingresar Query"></b-form-input>
                <b-table striped hover :items="tableData"></b-table>
            </b-tab>
            <b-tab title="Monitor de Variables productivas"></b-tab>
        </b-tabs>
    </b-container>
    `,
    data() {
        return {
            // variables for controlling the display of the main parts of the component.
            showMachines: false,
            showDatabase: false,
            showMonitor: false,
            showHomepage: true,
            // variables for the database table display, placeholder data for now.
            tableData: [
                { id: 1, machine: 'Promass 16', mold: '35 lbs', cycle_number: 1243, cycle_time: 270, steam_time: 100, cooling_time: 80, void_time: 90 },
                { id: 2, machine: 'Promass 16', mold: '35 lbs', cycle_number: 1245, cycle_time: 270, steam_time: 100, cooling_time: 80, void_time: 90 },
                { id: 3, machine: 'Promass 15', mold: '10 lbs', cycle_number: 1246, cycle_time: 270, steam_time: 100, cooling_time: 80, void_time: 90 },
                { id: 4, machine: 'Promass 14', mold: '75 lbs', cycle_number: 1543, cycle_time: 270, steam_time: 100, cooling_time: 80, void_time: 90 },
            ],
            // array of booleans to control the display of the active bigger card, empty at first.
            activeCard: [],
        }
    },
    methods: {
        /* TODO: Set up a way to make certain value fields to change their variant depending on the value. For example:
        ** if the value is too high, the variant should be danger, if it's too low, the variant should be warning, and if it's in the middle, the variant should be success. */
        cacheReplay: function () {
            uibuilder.send({ payload: "Hi there from the client", topic: "from the client", cacheControl: "REPLAY" });
        },

        toggleMachines: function () {
            if (this.showMachines === false) {
                this.showMachines = true;
                this.showHomepage = false;
                this.showDatabase = false;
                this.showMonitor = false;
            }
        },

        toggleDatabase: function () {
            if (this.showDatabase === false) {
                this.showMachines = false;
                this.showHomepage = false;
                this.showDatabase = true;
                this.showMonitor = false;
            }
        },

        toggleMonitor: function () {
            if (this.showMonitor === false) {
                this.showMachines = false;
                this.showHomepage = false;
                this.showDatabase = false;
                this.showMonitor = true;
            }
        },
    },
}