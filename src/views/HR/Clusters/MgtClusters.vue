<template>
  <v-app id="inspire">
    <!-- App Bar -->
    <v-app-bar app color="white" elevate-on-scroll>
      <!-- Back Button -->
      <v-btn icon @click="goBack">
        <v-icon>mdi-arrow-left</v-icon>
      </v-btn>

      <!-- Title -->
      <v-app-bar-title class="text-uppercase grey--text">
        <v-icon large class="mr-2">mdi-office-building</v-icon>
        <span>Cluster Management</span>
      </v-app-bar-title>

      <v-spacer></v-spacer>

      <!-- Add Cluster Button -->
      <v-btn icon @click="openAddClusterDialog">
        <v-icon>mdi-plus</v-icon>
      </v-btn>

      <!-- Refresh Button -->
      <v-btn icon @click="refreshPage">
        <v-icon>mdi-refresh</v-icon>
      </v-btn>
    </v-app-bar>

    <!-- Add Cluster Dialog -->
    <v-dialog v-model="dialog" persistent max-width="600px">
      <v-card>
        <v-card-title class="headline">Add Cluster</v-card-title>
        <v-card-text>
          <v-form @submit.prevent="submitClusterForm" id="UpdateForm">
            <!-- Cluster Name Field -->
            <v-text-field
              v-model="newCluster.ClusterName"
              name="ClusterName"
              label="Cluster Name"
              required
            ></v-text-field>

            <input type="hidden" name="TableName" value="clusters" />
            <!-- Description Field -->
            <v-textarea
              v-model="newCluster.Description"
              label="Description"
              name="Description"
              required
            ></v-textarea>

            <!-- CID Field -->
            <v-text-field
              v-model="newCluster.CID"
              label="CID"
              name="CID"
              required
              readonly
            ></v-text-field>

            <!-- Departments List Component -->
            <DeptsList />
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>

          <!-- Cancel Button -->
          <v-btn color="indigo" text @click="closeAddClusterDialog">
            <v-icon left>mdi-cancel</v-icon>
            Cancel
          </v-btn>

          <!-- Save Button -->
          <v-btn
            @click="submitClusterForm"
            color="red darken-1"
            text
            type="submit"
            :loading="loading"
          >
            <v-icon left>mdi-content-save</v-icon>
            Save
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <ViewCluster />
  </v-app>
</template>

<script>
import axios from "axios";
import Swal from "sweetalert2";
import DeptsList from "../Departments/DeptsList.vue";
import ViewCluster from "./ViewClusters.vue";

export default {
  components: {
    DeptsList,
    ViewCluster,
  },
  data() {
    return {
      dialog: false,
      loading: false,
      newCluster: {
        ClusterName: "",
        Description: "",
        TableName: "clusters",
        CID: "",
        DID: "",
      },
      departments: [],
    };
  },
  mounted() {
    this.fetchDepartments();
  },
  methods: {
    submitClusterForm: async function () {
      var form = document.getElementById("UpdateForm");
      var formData = new FormData(form);
      console.log(formData);
      // Client-side validation

      // for (var pair of formData.entries()) {
      //   console.log(pair[0] + ": " + pair[1]);
      // }
      if (
        !formData.get("ClusterName") ||
        !formData.get("Description") ||
        !formData.get("DID") ||
        !formData.get("CID")
      ) {
        Swal.fire({
          icon: "error",
          title: "Oops...",
          text: "Please fill in all required fields",
        });
        return;
      }

      // API Call with FormData
      try {
        const response = await axios.post(
          window.SERVER_URL + "MassInsert",
          formData,
          {
            headers: {
              "Content-Type": "multipart/form-data",
            },
          }
        );
        Swal.fire({
          icon: "success",
          title: "Submitted",
          text: JSON.stringify(response.data),
        });

        this.closeAddClusterDialog();
      } catch (error) {
        Swal.fire({
          icon: "error",
          title: "Error",
          text: error.message,
        });
      }
    },

    openAddClusterDialog() {
      this.newCluster.CID = this.generateRandomString(16);
      this.dialog = true;
    },

    goBack() {
      this.$router.go(-1);
    },

    refreshPage() {
      // Get the current route's path
      const currentPath = this.$route.path;

      // Use nextTick to ensure the current route is fully rendered before re-navigating
      this.$nextTick(() => {
        // Navigate to a temporary route and then immediately navigate back
        this.$router.replace("/MgtClusters").then(() => {
          this.$router.replace(currentPath);
        });
      });
    },

    closeAddClusterDialog() {
      this.dialog = false;
    },

    async fetchDepartments() {
      try {
        const response = await axios.get(
          window.SERVER_URL + "GlobalDataFetcher",
          {
            params: {
              TableName: "departments",
              ExcludeColumns: ["id", "Description", "created_at", "updated_at"],
            },
          }
        );
        if (response.data && Array.isArray(response.data.data)) {
          this.departments = response.data.data;
        } else {
          throw new Error("Invalid response structure");
        }
      } catch (error) {
        Swal.fire(
          "Error",
          "Failed to fetch departments: " + error.message,
          "error"
        );
      }
    },

    generateRandomString(length) {
      const characters =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
      let randomString = "";

      for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * characters.length);
        randomString += characters.charAt(randomIndex);
      }

      return randomString;
    },
  },
};
</script>
