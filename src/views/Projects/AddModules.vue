<template>
  <div>
    <v-dialog v-model="dialog" fullscreen eager>
      <v-card>
        <v-toolbar color="primary" dense flat>
          <v-card-title class="text-h5"> Add a new project module</v-card-title>
          <v-spacer></v-spacer>
          <v-btn icon @click="dialog = false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
        </v-toolbar>

        <v-card-text>
          <v-row justify="center">
            <v-col cols="12" md="12">
              <v-form ref="form" v-model="valid" id="AddModule">
                <FormEngine
                  :tableName="tableName"
                  :excludeColumns="excludeColumns"
                />

                <GlobalSelect
                  TableName="projects"
                  idField="ProjectID"
                  nameField="ProjectName"
                  :ExcludeColumns="['created_at', 'updated_at']"
                  label="Select Parent Project"
                />

                <v-text-field
                  name="MID"
                  type="hidden"
                  v-model="MID"
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
  </div>
</template>

<script>
import FormEngine from "@/utils/FormEngine"; // Adjust path as needed
import axios from "axios";
import Swal from "sweetalert2";
import GlobalSelect from "@/utils/GlobalSelect"; // Ensure the correct path

export default {
  components: {
    FormEngine,
    GlobalSelect, // Include GlobalSelect in the components
  },
  props: {
    externalDialog: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      valid: false,
      MID: null, // Add this new data property
      selectTableName: "projects",
      selectDisplayColumn: "ProjectName",
      selectBindColumn: "ProjectID",
      dialog: this.externalDialog,
      tableName: "project_modules",
      excludeColumns: ["id", "created_at", "updated_at", "MID", "ProjectID"],
    };
  },
  watch: {
    // Watch for changes in externalDialog prop
    externalDialog(newVal) {
      this.dialog = newVal;
    },
    // Watch for dialog visibility changes
    dialog(newVal) {
      if (newVal) {
        // Perform actions when dialog opens
      }
    },
  },
  created() {
    this.startMIDGenerator();
  },
  beforeDestroy() {
    clearInterval(this.MIDGeneratorInterval);
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
    startMIDGenerator() {
      this.MID = this.generateMID();
      this.MIDGeneratorInterval = setInterval(() => {
        this.MID = this.generateMID();
      }, 1000);
    },
    generateMID() {
      let MID = "";
      for (let i = 0; i < 15; i++) {
        MID += Math.floor(Math.random() * 10).toString();
      }
      return MID;
    },
    toggleDialog() {
      this.$emit("update:externalDialog", !this.dialog);
    },
    async submit() {
      const form = document.getElementById("AddModule");
      let emptyFields = [];

      // Iterate over form elements
      for (let element of form.elements) {
        // Check if element is an input, has a name attribute, and is not hidden
        if (
          element.tagName === "INPUT" &&
          element.name &&
          element.type !== "hidden"
        ) {
          let value = element.value.trim(); // Trim the value
          if (!value) {
            emptyFields.push(element.name); // Add the field's name to the array if empty
          }
        }
      }

      // Alert user if there are any empty fields
      if (emptyFields.length > 0) {
        const emptyFieldsList = emptyFields.join(", ");
        this.notifyUser(
          `Please fill in all the fields. Empty fields: ${emptyFieldsList}`,
          "error"
        );
        return;
      }

      const formData = new FormData(form);
      formData.append("TableName", this.tableName);

      try {
        const response = await axios.post(
          window.SERVER_URL + "MassInsert",
          formData
        );

        if (response.status === 200) {
          this.notifyUser(response.data[0].status, "success");
          this.$router.push({ name: "Loader" });
        } else {
          this.notifyUser(
            "Submission failed: " + response.data.message,
            "error"
          );
        }
      } catch (error) {
        console.error("Error submitting form:", error);
        this.notifyUser(
          "Submission failed: " + error.response.data.error_a,
          "error"
        );
      }
    },

    // Method to show notifications
    notifyUser(message, icon) {
      Swal.fire({
        title: message,
        icon: icon,
        confirmButtonText: "OK",
      });
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
