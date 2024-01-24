<template>
  <div>
    <v-app-bar app color="white" elevate-on-scroll>
      <!-- Back Button -->
      <v-btn icon @click="$router.back()">
        <v-icon>mdi-arrow-left</v-icon>
      </v-btn>

      <v-app-bar-title>
        <v-icon class="me-5">mdi-cog</v-icon> Projects
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

    <v-container>
      <div class="d-flex">
        <!-- Other content here -->

        <!-- Spacer to push the button to the end -->
        <v-spacer></v-spacer>

        <!-- Your Button -->
        <v-btn
          style="height: 25px"
          small
          color="red"
          @click="$router.push({ name: 'MgtModules' })"
        >
          <v-icon class="me-2" left size="small">mdi-folder</v-icon>
          Modules
        </v-btn>
      </div>
    </v-container>

    <data-viewer
      table-name="projects"
      updatePath="UpdateProjects"
      deleteTableName="projects"
      :display-columns="['ProjectName', 'ProjectDescription']"
      title="Manage Projects"
      :exclude-columns="['PID', 'created_at', 'updated_at', 'ProjectID']"
    ></data-viewer>

    <add-data :externalDialog.sync="dialog"></add-data>
  </div>
</template>

<script>
import DataViewer from "@/utils/DataViewer"; // Ensure the correct path
import AddData from "@/views/Projects/AddProjects"; // Ensure the correct path

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
