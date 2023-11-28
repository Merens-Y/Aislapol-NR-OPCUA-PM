// TODO: change view of mold to return the cycles since maintenance instead of the total cycles.
export default {
  props: ["pre_exp_arr", "mold_arr", "mold_control_values", "time_stamps", "last_running_time"],
  watch: {
    mold_arr(newValue) {
      // Whenever the value of 'mold_arr' changes, look for this.moldModal.content.machine_serial_number and see if it matches any of the machine_serial_number values in the new array:
      newValue.forEach((mold) => {
        if (this.moldModal.content.machine_serial_number === mold.machine_serial_number) {
          // If it does, update this.moldModal.content with the new values:
          this.moldModal.content = mold;
        }
      });
      // console.log("mold_arr changed");
    },
    // same as above but for pre_exp_arr:
    pre_exp_arr(newValue) {
      newValue.forEach((pre_exp) => {
        if (this.preexpModal.content.machine_serial_number === pre_exp.machine_serial_number) {
          this.preexpModal.content = pre_exp;
        }
      });
      // console.log("pre_exp_arr changed");
    },
  },
  template: `
    <b-container fluid>
        <div class="row">
            <div>{{ triggerCacheReplay() }}</div>
            <b-card style="cursor: pointer;" class="col-12 col-lg-5 col-xl-4 p-1 m-1" v-for="(pre_exp, pre_exp_key, index) in pre_exp_arr" v-bind:class="determineMachineState(pre_exp, false)" @click="preexpInfo(pre_exp)">
                <div class="row">
                    <p class="col p-1 m-1">{{pre_exp.machine_serial_number}}</p> <div class="col-" v-bind:class="determineMachineState(pre_exp, true)"></div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Material:</b></p></div>
                    <div class="col-md value-field text-center">Null</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Kg Procesados:</b></p></div>
                    <div class="col-md value-field text-center">Null</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Tiempo:</b></p></div>
                    <div class="col-md value-field text-center">{{formatDuration(pre_exp.working_time_total)}}</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Tot. ciclos:</b></p></div>
                    <div class="col-md value-field text-center">{{pre_exp.life_cycles}}</div>
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
            <b-card style="cursor: pointer;" class="col-12 col-md-5 col-lg-3 p-1 m-1" v-for="(mold, mold_key, index) in mold_arr" v-bind:class="determineMoldMachineState(mold, false)" @click="moldInfo(mold)">
                <div class="row">
                    <p class="col p-1 m-1">{{mold.machine_serial_number}} <b-badge variant="primary" v-if="mold.is_automatic">AUTO</b-badge><b-badge variant="light" v-if="mold.is_automatic">MANUAL</b-badge><b-badge variant="light" v-if="mold.is_manual">AUTO</b-badge><b-badge variant="danger" v-if="mold.is_manual">MANUAL</b-badge></p> <div class="col-" v-bind:class="determineMoldMachineState(mold, true)"></div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Receta molde:</b></p></div>
                    <div class="col-md value-field text-center">{{ mold.last_recipe_name.replace('.xml', '').toUpperCase() }}</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Ciclos/H:</b></p></div>
                    <div class="col-md value-field text-center">{{parseInt(Number(mold.cycles_per_second).toFixed(2))}}</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Dist. Molde:</b></p></div>
                    <div class="col-md value-field align-items-center text-center">{{mold.mold_distance.toFixed(2)}}</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>T. de Ciclo:</b></p></div>
                    <div class="col-md value-field align-items-center text-center" :class="getVariantClassbyTC(mold.current_cycle_time/1000, mold.last_recipe_name)">{{(mold.current_cycle_time/1000).toFixed(2)}}</div>
                    <div class="w-100"></div>
                    <div class="col-sm"><p><b>Tot. ciclos:</b></p></div>
                    <div class="col-md value-field text-center" :class="getVariantClassbyNC(mold.life_cycles, mold.last_recipe)">{{mold.life_cycles}}</div>
                </div>
            </b-card>
        </div>
        <!-- Info modal -->
        <b-modal size="xl" :id="moldModal.id" :title="moldModal.title" >
            <b-row>
              <b-col lg="2" class="my-1"><b>Fecha:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.currentDate}}</b-col>
              <b-col lg="2" class="my-1"><b>Receta:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.moldModal.content.last_recipe_name}}</b-col>
              <!-- <b-col lg="2" class="my-1"><b>Turno:</b></b-col>
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
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col> -->
              <b-col lg="2" class="my-1"><b>Horómetro Automático:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.formatDuration(this.moldModal.content.working_time_auto)}}</b-col>
              <b-col lg="2" class="my-1"><b>Horómetro Manual:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.formatDuration(this.moldModal.content.working_time_manual)}}</b-col>
              <b-col lg="2" class="my-1"><b>Horómetro Total:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.formatDuration(this.moldModal.content.working_time_total)}}</b-col>
              <b-col lg="2" class="my-1"><b>Horómetro Hidráulico:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.formatDuration(this.moldModal.content.working_time_hydraulic)}}</b-col>
              <b-col lg="2" class="my-1"><b>Alarma:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.moldModal.content.alarm_00_description}}</b-col>
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
              <b-col lg="2" class="my-1 value-field text-center">{{this.preexpModal.content.last_recipe_name}}</b-col>
              <b-col lg="2" class="my-1"><b>Encargado de Turno:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Operador:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Cantidad Producida:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col>
              <b-col lg="2" class="my-1"><b>Horómetro Automático:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.formatDuration(this.preexpModal.content.working_time_auto)}}</b-col>
              <b-col lg="2" class="my-1"><b>Horómetro Manual:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.formatDuration(this.preexpModal.content.working_time_manual)}}</b-col>
              <b-col lg="2" class="my-1"><b>Horómetro Total:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.formatDuration(this.preexpModal.content.working_time_total)}}</b-col>
              <b-col lg="2" class="my-1"><b>Tot. ciclos:</b></b-col>
              <b-col lg="2" class="my-1 value-field text-center">{{this.preexpModal.content.life_cycles}}</b-col>
              <!-- <b-col lg="2" class="my-1"><b>Tiempo de Término:</b></b-col>
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
              <b-col lg="2" class="my-1 value-field text-center">Placeholder</b-col> -->
              
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
    determineMachineState(pre_exp, is_led) {
      const is_connected = pre_exp.is_connected;
      const is_disconnected = pre_exp.is_disconnected;

      if (is_disconnected) {
        return is_led ? "led gray" : "text-secondary";
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
    moldInfo(machine_obj) {
      this.moldModal.title = `${machine_obj.machine_serial_number}`;
      this.$root.$emit("bv::show::modal", this.moldModal.id);
      this.moldModal.content = machine_obj;
      // console.log(this.mold_arr[String(moldModal.id)].working_time_auto.hours);
    },
    preexpInfo(machine_obj) {
      this.preexpModal.title = `${machine_obj.machine_serial_number}`;
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
    formatDuration(seconds) {
      const hours = Math.floor(seconds / 3600);
      const minutes = Math.floor((seconds % 3600) / 60);
      const remainingSeconds = seconds % 60;
    
      const formattedTime = `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}:${String(remainingSeconds).padStart(2, '0')}`;
    
      return formattedTime;
    },
  },
};
