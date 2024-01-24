<template>
  <v-main>
    <v-container>
      <!-- Search Bar -->
      <v-row>
        <v-col cols="12">
          <v-text-field
            v-model="search"
            label="Search Clusters"
            dense
            outlined
            append-outer-icon="mdi-magnify"
            class="search-bar"
            clearable
          ></v-text-field>
        </v-col>
      </v-row>

      <!-- Clusters Display -->
      <v-row>
        <v-col
          v-for="cluster in filteredClusters"
          :key="cluster.id"
          cols="12"
          md="4"
        >
          <v-card :elevation="2">
            <v-card-title>
              <v-icon :color="getIconColor(cluster)">{{
                getRandomIcon()
              }}</v-icon>
              {{ cluster.ClusterName }}
            </v-card-title>
            <v-card-text>{{ cluster.ClusterDescription }}</v-card-text>
            <v-card-actions>
              <v-btn text color="blue" @click="openDetailDialog(cluster)"
                >View</v-btn
              >
              <v-btn text color="green" @click="openEditDialog(cluster)"
                >Edit</v-btn
              >
              <v-btn text color="red" @click="confirmDelete(cluster.id)"
                >Delete</v-btn
              >
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>

      <!-- Detail Dialog -->
      <v-dialog v-model="detailDialog" max-width="800px">
        <v-card class="detail-modal">
          <v-card-title class="headline">
            <v-icon :color="getIconColor(currentCluster)">{{
              getRandomIcon()
            }}</v-icon>
            {{ currentCluster.ClusterName }}
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-row>
                <v-col
                  cols="12"
                  md="6"
                  v-for="(value, key) in currentCluster"
                  :key="key"
                >
                  <div class="info-item">
                    <v-icon class="info-icon me-3">{{
                      getRandomIcon()
                    }}</v-icon>
                    <span class="info-label">{{ formatLabel(key) }}:</span>
                    {{ value }}
                  </div>
                  <v-divider></v-divider>
                </v-col>
              </v-row>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-btn color="primary" text @click="detailDialog = false"
              >Close</v-btn
            >
          </v-card-actions>
        </v-card>
      </v-dialog>

      <!-- Edit Dialog -->
      <v-dialog v-model="editDialog" max-width="500px">
        <v-card>
          <v-card-title class="headline">
            <v-icon left>{{ getRandomIcon() }}</v-icon>
            Edit Cluster
          </v-card-title>
          <v-form @submit.prevent="saveCluster" id="EditClusterForm">
            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12">
                    <v-text-field
                      v-model="currentCluster.ClusterName"
                      label="Cluster Name"
                      required
                      name="ClusterName"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-textarea
                      v-model="currentCluster.ClusterDescription"
                      label="Description"
                      required
                      name="Description"
                    ></v-textarea>
                  </v-col>
                  <v-col cols="12">
                    <DeptsList
                      v-model="currentCluster.DepartmentName"
                      label="Department"
                      name="Department"
                    ></DeptsList>
                  </v-col>
                  <!-- Hidden Fields -->
                  <input name="id" type="hidden" v-model="currentCluster.id" />
                  <input type="hidden" value="clusters" name="TableName" />
                </v-row>
              </v-container>
            </v-card-text>
            <v-card-actions>
              <v-btn color="blue darken-1" type="submit">Save</v-btn>
              <v-btn color="grey" text @click="editDialog = false"
                >Cancel</v-btn
              >
            </v-card-actions>
          </v-form>
        </v-card>
      </v-dialog>

      <!-- Delete Confirmation Dialog -->
      <v-dialog v-model="deleteDialog" max-width="500px">
        <v-card>
          <v-card-title class="headline">Confirm Deletion</v-card-title>
          <v-card-text
            >Are you sure you want to delete this cluster?</v-card-text
          >
          <v-card-actions>
            <v-btn color="red darken-1" text @click="deleteCluster"
              >Delete</v-btn
            >
            <v-btn color="grey" text @click="deleteDialog = false"
              >Cancel</v-btn
            >
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-container>
  </v-main>
</template>

<script>
import axios from "axios";
import Swal from "sweetalert2";
import DeptsList from "../Departments/DeptsList.vue";
import {
  GlobalDataFetcher,
  GlobalDelete,
  GlobalDataInserter,
  GlobalUpdater,
} from "../../../api";

export default {
  components: {
    DeptsList,
  },
  data() {
    return {
      clusters: [],
      search: "",
      currentCluster: {},
      detailDialog: false,
      editDialog: false,
      deleteDialog: false,
      clusterToDelete: null,
    };
  },
  computed: {
    filteredClusters() {
      if (!this.search) return this.clusters;
      const searchLower = this.search.toLowerCase();
      return this.clusters.filter((cluster) => {
        const clusterName = cluster.ClusterName
          ? cluster.ClusterName.toLowerCase()
          : "";
        const description = cluster.ClusterDescription
          ? cluster.ClusterDescription.toLowerCase()
          : "";
        return (
          clusterName.includes(searchLower) || description.includes(searchLower)
        );
      });
    },
  },
  methods: {
    fetchClusters() {
      GlobalDataFetcher(
        "cluster_view",
        ["created_at", "updated_at", "DID", "CID"],
        (data) => {
          this.clusters = data;
        }
      );
    },
    getRandomIcon() {
      return window.icons[Math.floor(Math.random() * window.icons.length)];
    },
    getIconColor(cluster) {
      // Define the logic to determine the icon color
    },
    formatLabel(key) {
      return key
        .replace(/([A-Z])/g, " $1")
        .replace(/^./, (str) => str.toUpperCase());
    },
    openDetailDialog(cluster) {
      this.currentCluster = cluster;
      this.detailDialog = true;
    },
    openEditDialog(cluster) {
      this.currentCluster = { ...cluster };
      this.editDialog = true;
    },
    confirmDelete(clusterId) {
      this.clusterToDelete = clusterId;
      this.deleteDialog = true;
    },
    deleteCluster() {
      GlobalDelete("clusters", this.clusterToDelete, () => {
        Swal.fire("Deleted!", "The cluster has been deleted.", "success");
        this.fetchClusters();
        this.deleteDialog = false;
        this.clusterToDelete = null;
      });
    },
    saveCluster() {
      if (this.currentCluster.id) {
        GlobalUpdater(
          "EditClusterForm",
          () => {
            Swal.fire({
              title: "Success",
              text: "Cluster saved successfully",
              icon: "success",
              confirmButtonText: "Ok",
              customClass: {
                confirmButton: "swal-btn",
              },
            });
            this.fetchClusters();
            this.editDialog = false;
          },
          (error) => {
            console.error("Error saving cluster:", error);
            Swal.fire("Error", "Failed to save cluster", "error");
          }
        );
      } else {
        GlobalDataInserter(
          "EditClusterForm",
          () => {
            Swal.fire({
              title: "Success",
              text: "Cluster saved successfully",
              icon: "success",
              confirmButtonText: "Ok",
              customClass: {
                confirmButton: "swal-btn",
              },
            });
            this.fetchClusters();
            this.editDialog = false;
          },
          (error) => {
            console.error("Error saving cluster:", error);
            Swal.fire("Error", "Failed to save cluster", "error");
          }
        );
      }
    },
  },
  created() {
    this.fetchClusters();
  },
};
</script>

<style scoped>
.info-item {
  margin-bottom: 15px;
  display: flex;
  align-items: center;
}
.info-label {
  font-weight: 600;
  margin-right: 8px;
  color: #1976d2;
}

.swal-btn {
  background-color: #1976d2;
  color: white;
  border: none;
  border-radius: 4px;
  padding: 10px 20px;
  margin-top: 10px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.swal-btn:hover {
  background-color: #165a9c;
}
</style>
