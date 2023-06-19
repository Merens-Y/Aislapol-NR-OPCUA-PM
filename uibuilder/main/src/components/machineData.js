export default {
  props: ["pre_exp_arr", "mold_arr", "mold_control_values"],
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
            <div>{{ triggerCacheReplay() }}</div>
            <b-card style="cursor: pointer;" class="col-12 col-lg-5 col-xl-4 p-1 m-1" v-for="pre_exp in pre_exp_arr" v-bind:class="[pre_exp.estado.texto]" @click="preexpInfo(pre_exp)">
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
                </div>
            </b-card>
            <b-card style="cursor: pointer;" class="col-12 col-md-5 col-lg-3 p-1 m-1" v-for="mold in mold_arr" v-bind:class="[mold.estado.texto]" @click="moldInfo(mold)">
                <div class="row">
                    <p class="col p-1 m-1">Moldeador {{mold.numero}}</p> <div class="col-" v-bind:class="[mold.estado.led]"></div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Molde:</b></p></div>
                    <div class="col-md value-field text-center">{{ mold.molde.replace('.xml', '').toUpperCase() }}</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Ciclos/H:</b></p></div>
                    <div class="col-md value-field text-center">{{mold.ciclos_hora}}</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>T. de Ciclo:</b></p></div>
                    <div class="col-md align-items-center text-center" :class="getVariantClassbyTC(mold.tiempo_ciclo, mold.molde)">{{mold.tiempo_ciclo}}</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Tot. ciclos:</b></p></div>
                    <div class="col-md text-center" :class="getVariantClassbyNC(mold.ciclos_total, mold.molde)">{{mold.ciclos_total}}</div>                                                       
                </div>
            </b-card>
        </div>
        <!-- Info modal -->
        <b-modal size="xl" :id="moldModal.id" :title="moldModal.title" >
            <b-row>
              <b-col lg="2" class="my-1"><b>Fecha:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Producto:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Turno:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Encargado de Turno:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Operador:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Inicio de Ciclo:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Término de Ciclo:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Lote:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Código de Molde:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Horómetro:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Horómetro Manual:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Horómetro Total:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
            </b-row>
            <template #modal-footer="{ ok, cancel, hide }">
                <!-- Emulate built in modal footer ok and cancel button actions -->
                <b-button size="sm" variant="primary" @click="ok()">
                  OK
                </b-button>
            </template>
        </b-modal>
        <b-modal size="xl" :id="preexpModal.id" :title="preexpModal.title" >
            <b-row>
              <b-col lg="2" class="my-1"><b>Fecha:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Producto:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Encargado de Turno:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Operador:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Cantidad Producida:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Tiempo de Inicio:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Tiempo de Término:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Espumado total (Kg):</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Número de Silo:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Materia Prima:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Número de Lote de Materia Prima:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Densidad Media:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Tiempo de descanso Silo:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              
            </b-row>
            <template #modal-footer="{ ok, cancel, hide }">
                <!-- Emulate built in modal footer ok and cancel button actions -->
                <b-button size="sm" variant="primary" @click="ok()">
                  OK
                </b-button>
            </template>
        </b-modal>
    </b-container>
    `,
  data() {
    return {
      // variables for controlling the display of the main parts of the component.
      pre_exp_cards: [],
      mold_cards: [],

      // variables for controlling the display of the info modal.
      moldModal: {
        id: "mold-Modal",
        title: "",
        content: "",
      },
      preexpModal: {
        id: "preexp-Modal",
        title: "",
        content: "",
      },
      // variables for controlling the display color of the molding cycle number control values.
      stateClass: {
        danger: "bg-danger text-light",
        warning: "bg-warning text-dark",
        success: "bg-success text-light",
      },
    };
  },
  methods: {
    triggerCacheReplay() {
      this.$emit("cachereplay-event");
    },
    moldInfo(machine_obj) {
      this.moldModal.title = `Moldeadora numero: ${machine_obj.numero}`;
      this.$root.$emit("bv::show::modal", this.moldModal.id);
      this.content = machine_obj;
    },
    preexpInfo(machine_obj) {
      this.preexpModal.title = `Pre-expansor numero: ${machine_obj.numero}`;
      this.$root.$emit("bv::show::modal", this.preexpModal.id);
      this.content = machine_obj;
    },
    getVariantClassbyNC(cycleTime, moldType) {
      if (this.mold_control_values.length === 0 || this.mold_control_values.find((obj) => obj.mold_name === moldType) === undefined) {
        return "";
      }
      else {
        if (cycleTime > this.mold_control_values.find((obj) => obj.mold_name === moldType)["nc_max"]) {
          return this.stateClass.danger;
        } else if (cycleTime > this.mold_control_values.find((obj) => obj.mold_name === moldType)["nc_ideal"]) {
          return this.stateClass.warning;
        } else {
          return this.stateClass.success;
        }
      }
    },
    getVariantClassbyTC(cycleNumber, moldType) {
      if (this.mold_control_values.length === 0 || this.mold_control_values.find((obj) => obj.mold_name === moldType) === undefined) {
        return "";
      }
      else {
        if (cycleNumber > this.mold_control_values.find((obj) => obj.mold_name === moldType)["tc_max"]) {
          return this.stateClass.danger;
        } else if (cycleNumber > this.mold_control_values.find((obj) => obj.mold_name === moldType)["tc_ideal"]) {
          return this.stateClass.warning;
        } else {
          return this.stateClass.success;
        }
      }
    },
  },
};
