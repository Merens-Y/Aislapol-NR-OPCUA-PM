export default {
  props: ["pre_exp_arr", "mold_arr", "mold_control_values", "time_stamps", "last_running_time"],
  watch: {},
  template: `
    <b-container fluid>
        <div class="row">
            <div>{{ triggerCacheReplay() }}</div>
            <b-card style="cursor: pointer;" class="col-12 col-lg-5 col-xl-4 p-1 m-1" v-for="(pre_exp, pre_exp_key, index) in pre_exp_arr" v-bind:class="determineMachineState(pre_exp_key, false)" @click="preexpInfo(pre_exp, pre_exp_key)">
                <div class="row">
                    <p class="col p-1 m-1">{{pre_exp_key}}</p> <div class="col-" v-bind:class="determineMachineState(pre_exp_key, true)"></div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Material:</b></p></div>
                    <div class="col-md value-field text-center">Null</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Kg Procesados:</b></p></div>
                    <div class="col-md value-field text-center">Null</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Tiempo:</b></p></div>
                    <div class="col-md value-field text-center">{{pre_exp.life_total_working.hours}}:{{pre_exp.life_total_working.minutes}}:{{pre_exp.life_total_working.seconds}}</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Densidad:</b></p></div>
                    <b-col class="col-md value-field text-center">
                        <b-row class="no-gutters">
                            <div class="col">Null<br>min</div>
                            <div class="col">Null<br>avg</div>
                            <div class="col">Null<br>max</div>
                        </b-row>
                    </b-col>
                </div>
            </b-card>
            <b-card style="cursor: pointer;" class="col-12 col-md-5 col-lg-3 p-1 m-1" v-for="(mold, mold_key, index) in mold_arr" v-bind:class="determineMoldMachineState(mold_key, false)" @click="moldInfo(mold, mold_key)">
                <div class="row">
                    <p class="col p-1 m-1">{{mold_key}}</p> <div class="col-" v-bind:class="determineMoldMachineState(mold_key, true)"></div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Molde:</b></p></div>
                    <div class="col-md value-field text-center">{{ mold.last_recipe.replace('.xml', '').toUpperCase() }}</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Ciclos/H:</b></p></div>
                    <div class="col-md value-field text-center">Needs function</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>T. de Ciclo:</b></p></div>
                    <div class="col-md align-items-center text-center" :class="getVariantClassbyTC(mold.cycle_time, mold.last_recipe)">{{mold.cycle_time}}</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Tot. ciclos:</b></p></div>
                    <div class="col-md text-center" :class="getVariantClassbyNC(mold.life_cycles, mold.last_recipe)">{{mold.life_cycles}}</div>                                                       
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
              <b-col lg="2" class="my-1 value-field text-center">{{this.preexpModal.content.life_cycles}}</b-col>
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
    determineMachineState(pre_exp_key, is_led) {
      const disconnectedThreshold = 15000; // 15 seconds threshold for disconnection

      if (!this.time_stamps || !this.last_running_time || !this.time_stamps[pre_exp_key] || !this.last_running_time[pre_exp_key]) {
        return is_led ? "led gray" : "text-secondary";
      }

      const currentTime = new Date().getTime();
      const lastMsgTime = this.time_stamps[pre_exp_key];
      const lastRunningTime = this.last_running_time[pre_exp_key];

      if (currentTime - lastMsgTime >= disconnectedThreshold) {
        return is_led ? "led gray" : "text-secondary";
      }

      const total_working_seconds = this.pre_exp_arr[pre_exp_key].life_total_working.seconds +
        this.pre_exp_arr[pre_exp_key].life_total_working.minutes * 60 +
        this.pre_exp_arr[pre_exp_key].life_total_working.hours * 3600;

      if (total_working_seconds === lastRunningTime) {
        return is_led ? "led red" : "";
      }

      return is_led ? "led green" : "";
    },
    // TODO: implement determineMoldMachineState() for mold cards
    determineMoldMachineState(mold_key, is_led) {
      const disconnectedThreshold = 15000; // 15 seconds threshold for disconnection

      if (!this.time_stamps || !this.time_stamps[mold_key]) {
        return is_led ? "led gray" : "text-secondary";
      }

      const currentTime = new Date().getTime();
      const lastMsgTime = this.time_stamps[mold_key];

      if (currentTime - lastMsgTime >= disconnectedThreshold) {
        return is_led ? "led gray" : "text-secondary";
      }

      const isRunning = this.mold_arr[mold_key].status.running;

      if (isRunning === false) {
        return is_led ? "led red" : "";
      }

      return is_led ? "led green" : "";
    },
    moldInfo(machine_obj, machine_key) {
      this.moldModal.title = `${machine_key}`;
      this.$root.$emit("bv::show::modal", this.moldModal.id);
      this.moldModal.content = machine_obj;
    },
    preexpInfo(machine_obj, machine_key) {
      this.preexpModal.title = `${machine_key}`;
      this.$root.$emit("bv::show::modal", this.preexpModal.id);
      this.preexpModal.content = machine_obj;
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
