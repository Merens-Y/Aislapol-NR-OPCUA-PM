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
                    <p class="col p-1 m-1">{{mold.machine_serial_number}}</p> <div class="col-" v-bind:class="determineMoldMachineState(mold, true)"></div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Receta molde:</b></p></div>
                    <div class="col-md value-field text-center">{{ mold.last_recipe_name.replace('.xml', '').toUpperCase() }}</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Ciclos/H:</b></p></div>
                    <div class="col-md value-field text-center">Needs function</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>T. de Ciclo:</b></p></div>
                    <div class="col-md align-items-center text-center" :class="getVariantClassbyTC(mold.current_cycle_time/1000, mold.last_recipe_name)">{{mold.current_cycle_time/1000}}</div>
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
              <b-col lg="2" class="my-1 value-field text-center">{{this.currentDate}}</b-col>
              <b-col lg="2" class="my-1"><b>Receta:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.checkReturn(this.moldModal.content.last_recipe)}}</b-col>
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
              <b-col lg="2" class="my-1"><b>Horómetro Automático:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.checkReturn(this.moldModal.content.working_time_auto.hours)}}:{{this.checkReturn(this.moldModal.content.working_time_auto.minutes)}}:{{this.checkReturn(this.moldModal.content.working_time_auto.seconds)}}</b-col>
              <b-col lg="2" class="my-1"><b>Horómetro Manual:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.checkReturn(this.moldModal.content.working_time_manual.hours)}}:{{this.checkReturn(this.moldModal.content.working_time_manual.minutes)}}:{{this.checkReturn(this.moldModal.content.working_time_manual.seconds)}}</b-col>
              <b-col lg="2" class="my-1"><b>Horómetro Hidráulico:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.checkReturn(this.moldModal.content.working_time_hydraulic.hours)}}:{{this.checkReturn(this.moldModal.content.working_time_hydraulic.minutes)}}:{{this.checkReturn(this.moldModal.content.working_time_hydraulic.seconds)}}</b-col>
              <b-col lg="2" class="my-1"><b>Horómetro Total:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.checkReturn(this.moldModal.content.working_time_total.hours)}}:{{this.checkReturn(this.moldModal.content.working_time_total.minutes)}}:{{this.checkReturn(this.moldModal.content.working_time_total.seconds)}}</b-col>
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
              <b-col lg="2" class="my-1 value-field text-center">{{this.currentDate}}</b-col>
              <b-col lg="2" class="my-1"><b>Receta:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.checkReturn(this.preexpModal.content.last_recipe)}}</b-col>
              <b-col lg="2" class="my-1"><b>Encargado de Turno:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Operador:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Cantidad Producida:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Fecha de Inicio:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.checkReturn(this.preexpModal.content.life_start_time.day)}}/{{this.checkReturn(this.preexpModal.content.life_start_time.month)}}/{{this.checkReturn(this.preexpModal.content.life_start_time.year)}} a las {{this.checkReturn(this.preexpModal.content.life_start_time.hour)}}:{{this.checkReturn(this.preexpModal.content.life_start_time.minute)}}:{{this.checkReturn(this.preexpModal.content.life_start_time.second)}}</b-col>
              <b-col lg="2" class="my-1"><b>Horómetro Automático:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.checkReturn(this.preexpModal.content.life_auto_working.hours)}}:{{this.checkReturn(this.preexpModal.content.life_auto_working.minutes)}}:{{this.checkReturn(this.preexpModal.content.life_auto_working.seconds)}}</b-col>
              <b-col lg="2" class="my-1"><b>Horómetro Manual:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.checkReturn(this.preexpModal.content.life_manual_working.hours)}}:{{this.checkReturn(this.preexpModal.content.life_manual_working.minutes)}}:{{this.checkReturn(this.preexpModal.content.life_manual_working.seconds)}}</b-col>
              <b-col lg="2" class="my-1"><b>Horómetro Total:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.checkReturn(this.preexpModal.content.life_total_working.hours)}}:{{this.checkReturn(this.preexpModal.content.life_total_working.minutes)}}:{{this.checkReturn(this.preexpModal.content.life_total_working.seconds)}}</b-col>
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
      currentDate: new Date().toLocaleDateString(),
      // variables for controlling the display of the info modal.
      moldModal: {
        id: "mold-Modal",
        title: "",
        content: {
          "status":{"auto":false,"manual":false,"running":false,"stop":false},
          "working_time_auto":{"hours":88,"minutes":88,"seconds":88},
          "working_time_manual":{"hours":88,"minutes":88,"seconds":88},
          "working_time_total":{"hours":88,"minutes":88,"seconds":88},
          "working_time_hydraulic":{"hours":88,"minutes":88,"seconds":88},
          "alarm_00":{"id":88,"description":88},
          "last_recipe":"ck *** rock - paper - scissors - lizard - spo",
          "life_cycles":88,
          "mold_distance":88,
          "last_cycle_time":88,
          "cycle_time":88
        },
      },
      preexpModal: {
        id: "preexp-Modal",
        title: "",
        content: {
          "life_auto_working":{"hours":88,"minutes":88,"seconds":88},
          "life_manual_working":{"hours":88,"minutes":88,"seconds":88},
          "life_total_working":{"hours":88,"minutes":88,"seconds":88},
          "life_start_time":{"year":88,"month":88,"day":88,"hour":88,"minute":88,"second":88},
          "life_cycles":88,
          "last_recipe":88,
          "machine_working_time":{"m01":{"hours":88,"minutes":88,"seconds":88},
          "m02":{"hours":88,"minutes":88,"seconds":88},
          "m03":{"hours":88,"minutes":88,"seconds":88},
          "m04":{"hours":88,"minutes":88,"seconds":88},
          "m05":{"hours":88,"minutes":88,"seconds":88},
          "m06":{"hours":88,"minutes":88,"seconds":88},
          "m07":{"hours":88,"minutes":88,"seconds":88},
          "m08":{"hours":88,"minutes":88,"seconds":88},
          "m09":{"hours":88,"minutes":88,"seconds":88},
          "m10":{"hours":88,"minutes":88,"seconds":88},
          "m11":{"hours":88,"minutes":88,"seconds":88},
          "m12":{"hours":88,"minutes":88,"seconds":88},
          "m13":{"hours":88,"minutes":88,"seconds":88},
          "m14":{"hours":88,"minutes":88,"seconds":88},
          "m15":{"hours":88,"minutes":88,"seconds":88}}
        },
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
    determineMoldMachineState(mold, is_led) {
      const is_running = mold.is_running;
      const is_disconnected = mold.is_disconnected;

      if (is_disconnected) {
        return is_led ? "led gray" : "text-secondary";
      }

      if (!is_running) {
        return is_led ? "led red" : "";
      }

      return is_led ? "led green" : "";
    },
    moldInfo(machine_obj, machine_key) {
      this.moldModal.title = `${machine_key}`;
      this.$root.$emit("bv::show::modal", this.moldModal.id);
      this.moldModal.content = machine_obj;
      console.log(this.mold_arr[String(moldModal.id)].working_time_auto.hours);
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
    checkReturn(obj) {
      if (obj === undefined || obj === null) {
        return "N/A";
      } else {
        return obj;
      }
    },
  },
};
