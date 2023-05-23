export default {
  props: ["pre_exp_arr", "mold_arr"],
  watch: {
    pre_exp_arr(newVal) {
      // Perform actions when the prop value changes
      this.pre_exp_cards = [...newVal];
    },
    mold_arr(newVal) {
      // Perform actions when the prop value changes
      this.mold_cards = [...newVal];
    },
  },
  template: `
    <b-container fluid>
        <div class="row">
            <div>{{ cacheReplay() }}</div>
            <b-card style="cursor: pointer;" class="col-12 col-lg-5 col-xl-4 p-1 m-1" v-for="pre_exp in pre_exp_arr" v-bind:class="[pre_exp.estado.texto]" @click="info(pre_exp, $event.target)">
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
            <b-card style="cursor: pointer;" class="col-12 col-md-5 col-lg-3 p-1 m-1" v-for="mold in mold_arr" v-bind:class="[mold.estado.texto]" @click="info(mold, $event.target)">
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
                    <div class="col-md align-items-center text-center" :class="getVariantClassbyCN(mold.tiempo_ciclo, mold.molde)">{{mold.tiempo_ciclo}}</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Total de ciclos:</b></p></div>
                    <div class="col-md text-center" :class="getVariantClassbyTC(mold.ciclos_total, mold.molde)">{{mold.ciclos_total}}</div>                                                       
                </div>
            </b-card>
        </div>
        <!-- Info modal -->
        <b-modal :id="infoModal.id" :title="infoModal.title" ok-only @hide="resetInfoModal">
            <div v-html="infoModal.content"></div>
        </b-modal>
    </b-container>
    `,
  data() {
    return {
      // variables for controlling the display of the main parts of the component.
      pre_exp_cards: [],
      mold_cards: [],
      mold_nc_control_values: [
        // variables for controlling the display color of the molding cycle number control values.
        {
          name: "10lbs mix",
          ideal: 95,
          max: 110,
        },
        {
          name: "35lbs mix",
          ideal: 95,
          max: 110,
        },
        {
          name: "75lbs T",
          ideal: 100,
          max: 120,
        },
        {
          name: "75lbs F",
          ideal: 95,
          max: 120,
        },
      ],
      mold_tc_control_values: [
        // variables for controlling the display color of the molding total cycles control values.
        {
          name: "10lbs mix",
          ideal: 15000,
          max: 15000,
        },
        {
          name: "35lbs mix",
          ideal: 15000,
          max: 15000,
        },
        {
          name: "75lbs T",
          ideal: 15000,
          max: 15000,
        },
        {
          name: "75lbs F",
          ideal: 15000,
          max: 15000,
        },
      ],
      // variables for controlling the display of the info modal.
      infoModal: {
        id: "info-modal",
        title: "",
        content: "",
      },
    };
  },
  methods: {
    cacheReplay: function () {
      uibuilder.send({
        payload: "Hi there from the client",
        topic: "from the client",
        cacheControl: "REPLAY",
      });
    },
    info(machine_obj, card) {
      this.infoModal.title = `Máquina numero: ${machine_obj.numero}`;
      this.infoModal.content = `
        <b-card class="col-12 col-lg-5 col-xl-4 p-1 m-1">
            <div class="row">
                <p class="col p-1 m-1">Pre-Expansor </p> <div class="col- led green"></div>
                <div class="w-100"></div>
                <div class="col-sm"><p><b>Material: name</b></p></div>                                
                <div class="col-md value-field text-center">value</div>
                <div class="w-100"></div>
                <div class="col-sm"><p><b>Kg Procesados:</b></p></div>                                
                <div class="col-md value-field text-center">value</div>
                <div class="w-100"></div>
                <div class="col-sm"><p><b>Tiempo:</b></p></div>                                
                <div class="col-md value-field text-center">value</div>
                <div class="w-100"></div>
                <div class="col-sm"><p><b>Densidad:</b></p></div>                                
                <b-col class="col-md value-field text-center">
                    <b-row class="no-gutters">
                        <div class="col">value<br>min</div>
                        <div class="col">value<br>prom</div>
                        <div class="col">value<br>max</div>
                    </b-row>
                </b-col>
                <div class="w-100"></div>
                <b-col class="p-3"></b-col> 
            </div>
        </b-card>
      `;
      //   this.infoModal.content = JSON.stringify(machine_obj, null, 2);
      this.$root.$emit("bv::show::modal", this.infoModal.id, card);
    },
    resetInfoModal() {
      this.infoModal.title = "";
      this.infoModal.content = "";
    },
    getVariantClassbyCN(cycleNumber, moldType) {
      if (cycleNumber > this.mold_nc_control_values.find((obj) => obj.name === moldType)["max"]) {
        return "bg-danger";
      } else if (cycleNumber > this.mold_nc_control_values.find((obj) => obj.name === moldType)["ideal"]) {
        return "bg-warning";
      } else {
        return "bg-success";
      }
    },
    getVariantClassbyTC(cycleNumber, moldType) {
      if (cycleNumber > this.mold_tc_control_values.find((obj) => obj.name === moldType)["max"]) {
        return "bg-danger";
      } else if (cycleNumber > this.mold_tc_control_values.find((obj) => obj.name === moldType)["ideal"]) {
        return "bg-warning";
      } else {
        return "bg-success";
      }
    },
  },
};