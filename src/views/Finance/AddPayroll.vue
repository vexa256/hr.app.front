<template>
  <div>
    <v-dialog v-model="dialog" fullscreen eager>
      <v-card>
        <v-toolbar color="primary" dense flat>
          <v-card-title class="text-h5"> Add a new payroll</v-card-title>
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

                <!-- <GlobalSelect
                  TableName="projects"
                  idField="PayrollID"
                  nameField="ProjectName"
                  :ExcludeColumns="['created_at', 'updated_at']"
                  label="Select Parent Project"
                /> -->

                <v-text-field
                  name="PayrollID"
                  type="hidden"
                  v-model="PayrollID"
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
// import GlobalSelect from "@/utils/GlobalSelect"; // Ensure the correct path

export default {
  components: {
    FormEngine,
    // GlobalSelect, // Include GlobalSelect in the components
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
      PayrollID: null, // Add this new data property
      selectTableName: "payroll_labels",
      selectDisplayColumn: "PayrollName",
      selectBindColumn: "PayrollID",
      dialog: this.externalDialog,
      tableName: "payroll_labels",
      excludeColumns: [
        "id",
        "created_at",
        "updated_at",
        "PayrollID",
        "PayrollID",
      ],
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
    this.startPayrollIDGenerator();
  },
  beforeDestroy() {
    clearInterval(this.PayrollIDGeneratorInterval);
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
    startPayrollIDGenerator() {
      this.PayrollID = this.generatePayrollID();
      this.PayrollIDGeneratorInterval = setInterval(() => {
        this.PayrollID = this.generatePayrollID();
      }, 1000);
    },
    generatePayrollID() {
      let PayrollID = "";
      for (let i = 0; i < 15; i++) {
        PayrollID += Math.floor(Math.random() * 10).toString();
      }
      return PayrollID;
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
