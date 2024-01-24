<template>
  <div>
    <v-app-bar app color="white" elevate-on-scroll>
      <v-app-bar-title
        ><v-icon class="me-5">mdi-cog</v-icon> Positions</v-app-bar-title
      >
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
      table-name="positions"
      updatePath="UpdatePositions"
      deleteTableName="positions"
      :display-columns="['Position', 'Description']"
      title="Manage Positions"
      :exclude-columns="['PID', 'created_at', 'updated_at']"
    ></data-viewer>
    <add-position :externalDialog.sync="dialog"></add-position>
  </div>
</template>

<script>
import DataViewer from "@/utils/DataViewer"; // Ensure the correct path
import AddPosition from "./AddPosition.vue"; // Ensure the correct path

export default {
  components: {
    DataViewer,
    AddPosition,
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

<!-- <template>
  <div>
    <record-form-engine
      table-name="clusters"
      :record-id="selectedRecordId"
      :exclude-columns="['id', 'created_at', 'updated_at']"
    ></record-form-engine>
  </div>
</template>

<script>
import RecordFormEngine from "../../../utils/UpdateEngine";

export default {
  components: {
    RecordFormEngine,
  },
  data() {
    return {
      selectedRecordId: 7, // Replace with the actual record ID you want to fetch
    };
  },
  // other options...
};
</script> -->
