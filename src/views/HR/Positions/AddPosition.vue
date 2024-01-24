<template>
  <!-- <v-btn
    fab
    color="primary"
    @click="dialog = !dialog"
    :style="{
      position: 'fixed',
      right: '20px',
      top: '209px',
      zIndex: '1000',
    }"
  >
    <v-icon>mdi-plus</v-icon>
  </v-btn> -->

  <v-dialog v-model="dialog" fullscreen>
    <v-card>
      <v-toolbar color="primary" dense flat>
        <v-card-title class="text-h5">Add a new position</v-card-title>
        <v-spacer></v-spacer>
        <v-btn icon @click="dialog = false">
          <v-icon>mdi-close</v-icon>
        </v-btn>
      </v-toolbar>

      <v-card-text>
        <v-row justify="center">
          <v-col cols="12" md="12">
            <v-form ref="form" v-model="valid" id="AddPosition">
              <FormEngine
                :tableName="tableName"
                :excludeColumns="excludeColumns"
              />

              <v-text-field
                name="PID"
                type="hidden"
                v-model="PID"
              ></v-text-field>

              <v-btn
                :disabled="!valid"
                @click="submit"
                color="primary"
                class="elevation-2"
              >
                <v-icon left>mdi-content-save</v-icon>Save
              </v-btn>
            </v-form>
          </v-col>
        </v-row>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
import FormEngine from "@/utils/FormEngine"; // Adjust path as needed
import axios from "axios";
import Swal from "sweetalert2";

export default {
  props: {
    externalDialog: {
      type: Boolean,
      default: false,
    },
  },
  components: {
    FormEngine,
  },
  data() {
    return {
      valid: false,
      PID: null, // Add this new data property

      dialog: this.externalDialog,
      tableName: "positions",
      excludeColumns: ["id", "created_at", "updated_at", "PID"],
    };
  },
  watch: {
    // Watch for changes in externalDialog prop
    externalDialog(newVal) {
      this.dialog = newVal;
    },
  },
  created() {
    this.startPIDGenerator();
  },
  beforeDestroy() {
    clearInterval(this.pidGeneratorInterval);
  },
  computed: {
    internalDialog: {
      get() {
        return this.externalDialog;
      },
      set(value) {
        this.$emit("update:externalDialog", value);
      },
    },
  },
  methods: {
    startPIDGenerator() {
      this.PID = this.generatePID();
      this.pidGeneratorInterval = setInterval(() => {
        this.PID = this.generatePID();
      }, 1000);
    },
    generatePID() {
      let pid = "";
      for (let i = 0; i < 15; i++) {
        pid += Math.floor(Math.random() * 10).toString();
      }
      return pid;
    },
    toggleDialog() {
      this.$emit("update:externalDialog", !this.dialog);
    },
    async submit() {
      const form = document.getElementById("AddPosition");
      let allFieldsFilled = true;

      for (let element of form.elements) {
        if (
          element.tagName === "INPUT" &&
          element.type !== "hidden" &&
          !element.value
        ) {
          allFieldsFilled = false;
          break;
        }
      }

      if (!allFieldsFilled) {
        this.notifyUser("Please fill in all the fields", "error");
        return;
      }

      const formData = new FormData(form);
      formData.append("TableName", this.tableName);

      try {
        const response = await axios.post(
          window.SERVER_URL + "MassInsert",
          formData
        );

        // Check for successful response (status code 200)
        if (response.status === 200) {
          this.notifyUser(response.data[0].status, "success");
        } else {
          // Handle non-200 responses
          this.notifyUser(
            "Submission failed: " + response.data.message,
            "error"
          );
        }
      } catch (error) {
        console.error("Error submitting form:", error);
        // Display error in Swal and log detailed error to console
        this.notifyUser(
          "Submission failed: " + error.response.data.error_a,
          "error"
        );
      }
    },

    notifyUser(message, icon) {
      Swal.fire({
        title: message,
        icon: icon,
        confirmButtonText: "OK",
      });
    },
  },
};
</script>
