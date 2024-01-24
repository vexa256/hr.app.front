<template>
  <v-dialog v-model="dialog" fullscreen>
    <v-card>
      <v-toolbar color="primary" dense flat>
        <v-card-title class="text-h5">Add a new project</v-card-title>
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
                name="ProjectID"
                type="hidden"
                v-model="ProjID"
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
      ProjID: null, // Add this new data property

      dialog: this.externalDialog,
      tableName: "projects",
      excludeColumns: ["id", "created_at", "updated_at", "ProjectID"],
    };
  },
  watch: {
    // Watch for changes in externalDialog prop
    externalDialog(newVal) {
      this.dialog = newVal;
    },
  },
  created() {
    this.startProjIDGenerator();
  },
  beforeDestroy() {
    clearInterval(this.ProjIDGeneratorInterval);
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
    startProjIDGenerator() {
      this.ProjID = this.generateProjID();
      this.ProjIDGeneratorInterval = setInterval(() => {
        this.ProjID = this.generateProjID();
      }, 1000);
    },
    generateProjID() {
      let ProjID = "";
      for (let i = 0; i < 15; i++) {
        ProjID += Math.floor(Math.random() * 10).toString();
      }
      return ProjID;
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
