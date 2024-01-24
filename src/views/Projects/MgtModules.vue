<template>
  <div>
    <v-app-bar app color="white" elevate-on-scroll>
      <!-- Back Button -->
      <v-btn icon @click="$router.back()">
        <v-icon>mdi-arrow-left</v-icon>
      </v-btn>

      <v-app-bar-title>
        <v-icon class="me-5">mdi-cog</v-icon> Modules
      </v-app-bar-title>

      <v-spacer></v-spacer>

      <v-btn icon @click="toggleDialog">
        <v-icon>mdi-plus</v-icon>
      </v-btn>

      <!-- Refresh Button -->
      <router-link :to="{ name: 'Loader' }">
        <v-btn icon>
          <v-icon>mdi-refresh</v-icon>
        </v-btn>
      </router-link>
    </v-app-bar>

    <data-viewer
      table-name="projectmodules"
      updatePath="UpdateModule"
      deleteTableName="project_modules"
      :display-columns="['ProjectModule', 'Description']"
      title="Manage Modules"
      :exclude-columns="['MID', 'created_at', 'updated_at', 'ProjectID']"
    ></data-viewer>

    <add-data :externalDialog.sync="dialog"></add-data>
  </div>
</template>

<script>
import DataViewer from "@/utils/DataViewer"; // Ensure the correct path
import AddData from "@/views/Projects/AddModules"; // Ensure the correct path
import GlobalSelect from "@/utils/GlobalSelect"; // Ensure the correct path

export default {
  components: {
    DataViewer,
    GlobalSelect,
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
