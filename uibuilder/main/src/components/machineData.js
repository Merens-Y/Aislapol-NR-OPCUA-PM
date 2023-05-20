//http://127.0.0.1:1880 for localhost, must define for later stages of developent.
// const api_url = 'http://192.168.1.104:1880';
export default {
    props: ['pre_exp_arr', 'mold_arr'],
    template:`
    <b-row>
        <div class="mt-3">
            <b-button-group lg="4" class="pb-2" size="lg">
                <b-button variant="outline-info" @click="toggleMachines">Estado de Maquinarias</b-button>
                <b-button variant="outline-info" @click="toggleDatabase">Base de Datos</b-button>
                <b-button variant="outline-info" @click="toggleMonitor">Monitor de Variables productivas</b-button>
            </b-button-group>
        </div>
        <div class="w-100"></div>
        <b-col cols="12">
            <b-card v-if="showMachines">
                <div>{{ cacheReplay() }}</div>
                <h3 slot="header">Estado de Maquinarias</h3>
                <div class="row">
                    <div class="card col-lg" v-for="pre_exp in pre_exp_arr" v-bind:class="[pre_exp.estado.texto]">
                            <div class="row">
                                <p class="col">Pre-Expansor {{pre_exp.numero}}</p> <div class="col-" v-bind:class="[pre_exp.estado.led]"></div>
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
                                        <div class="col value-field">{{pre_exp.densidad.avg}}<br>prom</div>
                                        <div class="col value-field">{{pre_exp.densidad.max}}<br>max</div>
                                    </b-row>
                                    
                                </b-col>
                                <div class="w-100"></div>
                                <b-col class="p-3"></b-col> 
                            </div>                                                             
                        
                    </div>
                    <div class="card col-md" v-for="mold in mold_arr" v-bind:class="[mold.estado.texto]">
                        <div class="row">
                            <p class="col">Moldeador {{mold.numero}}</p> <div class="col-" v-bind:class="[mold.estado.led]"></div>
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
                    </div>
                </div>
            </b-card>
            <b-card v-if="showDatabase">
                <h3 slot="header">Base de Datos</h3>
                <b-form-input id="type-search" placeholder="Ingresar Query"></b-form-input>
                <b-table striped hover :items="tableData"></b-table>
            </b-card>
            <b-card v-if="showMonitor">
                <h3 slot="header">Monitor de Variables Productivas</h3>
            </b-card>
        </b-col>
        
    </b-row>
    `,
    data () {
        return{
            showMachines: false,
            showDatabase: false,
            showMonitor: false,
            showHomepage: true,
            tableData: [
                { age: 40, first_name: 'Dickerson', last_name: 'Macdonald' },
                { age: 21, first_name: 'Larsen', last_name: 'Shaw' },
                { age: 89, first_name: 'Geneva', last_name: 'Wilson' },
                { age: 38, first_name: 'Jami', last_name: 'Carney' }
            ],
        }
    },
    methods: {
        cacheReplay: function(){
            uibuilder.send({payload: "Hi there from the client", topic: "from the client", cacheControl: "REPLAY"});
        },

        toggleMachines: function(){
            if(this.showMachines===false){
                this.showMachines = true;
                this.showHomepage = false;
                this.showDatabase = false;
                this.showMonitor = false;
            }
        },

        toggleDatabase: function(){
            if(this.showDatabase===false){
                this.showMachines = false;
                this.showHomepage = false;
                this.showDatabase = true;
                this.showMonitor = false;
            }
        },

        toggleMonitor: function(){
            if(this.showMonitor===false){
                this.showMachines = false;
                this.showHomepage = false;
                this.showDatabase = false;
                this.showMonitor = true;
            }
        },
    },
}