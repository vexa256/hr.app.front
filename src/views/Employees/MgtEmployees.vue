<template>
  <div>
    <v-app-bar app color="white" elevate-on-scroll>
      <v-app-bar-title>
        <v-icon class="me-5">mdi-cog</v-icon> Employees
      </v-app-bar-title>

      <v-spacer></v-spacer>

      <v-btn icon @click="toggleDialog">
        <v-icon>mdi-plus</v-icon>
      </v-btn>

      <v-btn icon @click="fetchData">
        <v-icon>mdi-refresh</v-icon>
      </v-btn>
    </v-app-bar>

    <!-- <data-viewer
      table-name="positions"
      :display-columns="['Position', 'Description']"
      title="Manage Positions"
      :exclude-columns="['PID', 'created_at', 'updated_at']"
    ></data-viewer> -->

    <data-viewer
      table-name="employees"
      updatePath="UpdateEmployees"
      deleteTableName="employees"
      :display-columns="['StaffName', 'RoleID']"
      title="Manage Employees"
      :exclude-columns="[
        'id',
        'created_at',
        'updated_at',
        'HOD',
        'EmpID',
        'Nationality',
        'IDScan',
        'Gender',
        'EmployeeType',
        'ProjectID',
        'AssignedPayroll',
        'DepartmentID',
        'PayrollID',
        'RoleID',
        'ReportsTo',
        'ReportsToRoleID',
        'DepartmentID',
        'ClusterID',
        'SoonExpiring',
        'StaffPhoto',
        'RecordStatus',
        'uuid',
        'EmpID',
      ]"
    ></data-viewer>
    <add-data :externalDialog.sync="dialog"></add-data>
  </div>
</template>

<script>
import DataViewer from "@/utils/DataViewer"; // Ensure the correct path
import AddData from "@/views/Employees/AddEmployees"; // Ensure the correct path

export default {
  components: {
    DataViewer,
    AddData,
  },
  data() {
    return {
      dialog: false,
    };
  },
  methods: {
    toggleDialog() {
      this.dialog = !this.dialog;
    },
  },
  // other options...
};
</script>
