<template>
  <div>
    <v-dialog v-model="dialog" fullscreen eager>
      <v-card>
        <v-toolbar color="primary" dense flat>
          <v-card-title class="text-h5">Add Employee</v-card-title>
          <v-spacer></v-spacer>
          <v-btn icon @click="dialog = false">
            <v-icon>mdi-close</v-icon>
          </v-btn>
        </v-toolbar>

        <v-card-text>
          <v-row justify="center">
            <v-col cols="12" md="12">
              <v-form ref="form" v-model="valid" id="AddModule">
                <v-row>
                  <GlobalSelect
                    TableName="payroll_labels"
                    idField="PayrollID"
                    nameField="PayrollName"
                    :ExcludeColumns="['created_at', 'updated_at']"
                    label="Select Payroll"
                    hiddenFieldName="AssignedPayroll"
                  />

                  <v-col cols="12" md="4" lg="4">
                    <Countries />
                  </v-col>

                  <v-col cols="12" md="4" lg="4">
                    <v-autocomplete
                      label="Sex"
                      :items="['Female', 'Male']"
                      v-model="gender"
                      prepend-icon="mdi-account"
                    ></v-autocomplete>
                  </v-col>

                  <v-col cols="12" md="4" lg="4">
                    <v-autocomplete
                      label="Employee Type"
                      :items="['Local', 'International']"
                      v-model="employeeType"
                      prepend-icon="mdi-account"
                    ></v-autocomplete>
                  </v-col>

                  <GlobalSelect
                    TableName="positions"
                    idField="PID"
                    nameField="Position"
                    :ExcludeColumns="['created_at', 'updated_at']"
                    label="Staff Designation"
                    hiddenFieldName="RoleID"
                  />

                  <GlobalSelect
                    TableName="positions"
                    idField="PID"
                    nameField="Position"
                    :ExcludeColumns="['created_at', 'updated_at']"
                    label="Reports To"
                    hiddenFieldName="ReportsTo"
                  />

                  <GlobalSelect
                    TableName="departments"
                    idField="DID"
                    nameField="DepartmentName"
                    :ExcludeColumns="['created_at', 'updated_at']"
                    label="Select Department"
                    hiddenFieldName="DepartmentID"
                  />

                  <GlobalSelect
                    TableName="clusters"
                    idField="CID"
                    nameField="ClusterName"
                    :ExcludeColumns="['created_at', 'updated_at']"
                    label="Select Cluster"
                    hiddenFieldName="ClusterID"
                    mdSize="4"
                    lgSize="4"
                  />

                  <GlobalSelect
                    TableName="projects"
                    idField="ProjectID"
                    nameField="ProjectName"
                    :ExcludeColumns="['created_at', 'updated_at']"
                    label="Select Project"
                    hiddenFieldName="ProjectID"
                    mdSize="4"
                    lgSize="4"
                  />


                  
                  <FormEngine
                    :tableName="tableName"
                    :excludeColumns="excludeColumns"
                  />
                </v-row>

                <v-text-field
                  name="EmpID"
                  type="hidden"
                  v-model="EmpID"
                ></v-text-field>

                <v-text-field
                  name="uuid"
                  type="hidden"
                  v-model="EmpID"
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
import GlobalSelect from "@/utils/AdvancedSelect"; // Ensure the correct path
import Countries from "@/utils/Countries"; // Ensure the correct path

export default {
  components: {
    FormEngine,
    Countries, // Include GlobalSelect in the components
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
      gender: null,
      employeeType: null,
      valid: false,
      EmpID: null, // Add this new data property
      selectTableName: "employees",
      selectDisplayColumn: "StaffName",
      selectBindColumn: "EmpID",
      dialog: this.externalDialog,
      tableName: "employees",
      excludeColumns: [
        "id",
        "created_at",
        "updated_at",
        "HOD",
        "EmpID",
        "Nationality",
        "IDScan",
        "Gender",
        "EmployeeType",
        "ProjectID",
        "AssignedPayroll",
        "DepartmentID",
        "PayrollID",
        "RoleID",
        "ReportsTo",
        "ReportsToRoleID",
        "DepartmentID",
        "ClusterID",
        "SoonExpiring",
        "StaffPhoto",
        "RecordStatus",
        "uuid",
        "EmpID",
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
    this.startEmpIDGenerator();
  },
  beforeDestroy() {
    clearInterval(this.EmpIDGeneratorInterval);
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
    startEmpIDGenerator() {
      this.EmpID = this.generateEmpID();
      this.EmpIDGeneratorInterval = setInterval(() => {
        this.EmpID = this.generateEmpID();
      }, 1000);
    },
    generateEmpID() {
      let EmpID = "";
      for (let i = 0; i < 15; i++) {
        EmpID += Math.floor(Math.random() * 10).toString();
      }
      return EmpID;
    },
    toggleDialog() {
      this.$emit("update:externalDialog", !this.dialog);
    },
    async submit() {
      const form = document.getElementById("AddModule");
      const formData = new FormData(form);
      formData.append("TableName", "employees");
      formData.append("Gender", this.gender);
      formData.append("EmployeeType", this.employeeType);
      console.clear();

      // Log FormData entries for debugging
      for (let [key, value] of formData.entries()) {
        console.log(`${key}: ${value}`);
      }

      try {
        const response = await axios.post(
          window.SERVER_URL + "MassInsert",
          formData
        );

        if (response.status === 200 && response.data[0].status) {
          this.notifyUser("Submission successful", "success");
          this.$router.push({ name: "Loader" });
          console.log("Error Data " + response);
        } else {
          console.log("Error Data " + response);
          throw new Error("Server responded with an error: " + response);
        }
      } catch (error) {
        console.log("Error Data " + error);
        console.log("Error Data " + error);

        console.error("Error submitting form:", error);
        this.notifyUser(
          "Submission failed: " +
            (error.response?.data?.error_a || error.message),
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
