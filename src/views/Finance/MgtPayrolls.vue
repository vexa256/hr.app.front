<template>
  <div>
    <v-app-bar app color="white" elevate-on-scroll>
      <v-app-bar-title>
        <v-icon class="me-5">mdi-cog</v-icon> Payrolls
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
      table-name="payroll_labels"
      updatePath="UpdatePayroll"
      deleteTableName="payroll_labels"
      :display-columns="['PayrollName', 'Description']"
      title="Manage Payroll"
      :exclude-columns="['PayrollID', 'created_at', 'updated_at']"
    ></data-viewer>
    <add-payroll :externalDialog.sync="dialog"></add-payroll>
  </div>
</template>

<script>
import DataViewer from "@/utils/DataViewer"; // Ensure the correct path
import AddPayroll from "@/views/Finance/AddPayroll"; // Ensure the correct path

export default {
  components: {
    DataViewer,
    AddPayroll,
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
