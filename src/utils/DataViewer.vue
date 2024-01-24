<template>
  <v-app id="inspire">
    <v-main class="bg-grey-lighten-2">
      <v-container fluid>
        <!-- Search Bar -->
        <v-row justify="center">
          <v-col cols="12" md="8">
            <v-text-field
              v-model="search"
              label="Search Records"
              dense
              outlined
              append-outer-icon="mdi-magnify"
              clearable
            />
          </v-col>
        </v-row>

        <!-- Record Cards -->
        <v-row>
          <v-col
            v-for="record in filteredRecords"
            :key="record.id"
            cols="12"
            md="4"
          >
            <v-hover v-slot:default="{ hover }">
              <v-card :class="hover ? 'elevate-card' : ''" class="record-card">
                <v-card-title class="card-header">
                  <v-icon left>{{ getRandomIcon() }}</v-icon>
                  {{ getDisplayName(record, displayColumns[0]) }}
                </v-card-title>
                <v-card-text>
                  {{ getDisplayName(record, displayColumns[1]) }}
                </v-card-text>
                <v-card-actions>
                  <v-btn text color="primary" @click="openDetailDialog(record)"
                    >View</v-btn
                  >
                  <v-btn text color="secondary" @click="openEditDialog(record)"
                    >Edit</v-btn
                  >
                  <v-btn text color="error" @click="confirmDelete(record.id)"
                    >Delete</v-btn
                  >
                </v-card-actions>
              </v-card>
            </v-hover>
          </v-col>
        </v-row>

        <!-- Detail Dialog -->
        <v-dialog
          v-model="detailDialog"
          fullscreen
          transition="dialog-bottom-transition"
          class="detail-dialog"
        >
          <v-card flat class="dialog-card">
            <v-toolbar dense flat color="primary">
              <v-toolbar-title class="white--text"
                >View more details</v-toolbar-title
              >
              <v-spacer></v-spacer>
              <v-btn icon @click="detailDialog = false">
                <v-icon class="white--text">mdi-close</v-icon>
              </v-btn>
            </v-toolbar>

            <v-container fluid class="detail-container">
              <!-- Data Display -->
              <v-row>
                <v-col
                  v-for="(value, key, index) in detailedRecord"
                  :key="key"
                  v-if="key !== 'id'"
                  cols="12"
                  sm="6"
                  md="4"
                >
                  <v-card class="data-card" elevation="2">
                    <v-card-title>
                      <v-icon class="data-icon me-2">{{
                        getRandomIcon()
                      }}</v-icon>
                      <span class="primary--text">{{ formatLabel(key) }}</span>
                    </v-card-title>
                    <v-card-text>{{ value }}</v-card-text>
                  </v-card>
                </v-col>
              </v-row>
            </v-container>
          </v-card>
        </v-dialog>

        <!-- Edit Dialog -->
        <v-dialog
          v-model="isEditDialogOpen"
          fullscreen
          transition="dialog-bottom-transition"
          class="edit-dialog"
        >
          <v-card flat class="dialog-card">
            <v-toolbar dense flat color="primary">
              <v-toolbar-title class="white--text">Edit Record</v-toolbar-title>
              <v-spacer></v-spacer>
              <v-btn icon @click="isEditDialogOpen = false">
                <v-icon class="white--text">mdi-close</v-icon>
              </v-btn>
            </v-toolbar>
            <form id="GlobalDataUpdater" @submit.prevent="submitForm">
              <v-card-actions class="justify-end">
                <v-btn color="primary" type="submit">Save</v-btn>
                <v-btn color="red" text @click="isEditDialogOpen = false"
                  >Cancel</v-btn
                >
              </v-card-actions>

              <v-container fluid>
                <record-form-engine
                  :tableName="tableName"
                  :exclude-columns="excludeColumns"
                  :record-id="selectedRecordId"
                  @updateComplete="fetchData"
                ></record-form-engine>
              </v-container>
            </form>
          </v-card>
        </v-dialog>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import { ref, computed, onMounted } from "vue";
import axios from "axios";
import Swal from "sweetalert2";
import RecordFormEngine from "@/utils/UpdateEngine.vue"; // Adjust the path as needed
import { useRoute, useRouter } from "vue-router"; // Import useRouter and useRoute from vue-router

export default {
  components: {
    RecordFormEngine,
  },
  props: {
    deleteTableName: String,
    updatePath: String, // New prop for the update route path

    tableName: String,
    displayColumns: Array,
    title: String,
    columnMapping: {
      type: Object,
      default: () => ({}),
    },
    excludeColumns: {
      type: Array,
      default: () => ["created_at", "updated_at"],
    },
  },
  setup(props) {
    const router = useRouter();
    const route = useRoute();

    const records = ref([]);
    const search = ref("");
    const detailedRecord = ref({});
    const detailDialog = ref(false);
    const isEditDialogOpen = ref(false);
    const selectedRecordId = ref(null);

    const submitForm = async () => {
      const form = document.getElementById("GlobalDataUpdater");
      if (!form) {
        console.error("Form not found");
        return;
      }

      try {
        const formData = new FormData(form);
        const response = await axios.post(
          window.SERVER_URL + "MassUpdate",
          formData
        );

        // Handle server response
        if (response.data.errors) {
          Swal.fire({
            title: "Error!",
            text: "There were errors in your submission",
            icon: "error",
            confirmButtonText: "OK",
          });
        } else {
          Swal.fire({
            title: "Success!",
            text: "Your changes have been saved successfully",
            icon: "success",
            confirmButtonText: "OK",
          });
          sessionStorage.setItem("selectedRecordId", record.id);

          fetchData(); // Refresh data after a successful update
        }
      } catch (error) {
        Swal.fire({
          title: "Error!",
          text: error.message,
          icon: "error",
          confirmButtonText: "OK",
        });
      }
    };

    const fetchData = () => {
      axios
        .post(window.SERVER_URL + "GlobalDataFetcher", {
          TableName: props.tableName,
          ExcludeColumns: props.excludeColumns,
        })
        .then((response) => {
          records.value = response.data.data;
        })
        .catch((error) => {
          console.error("Error fetching data:", error);
          Swal.fire("Error", "Failed to fetch data", "error");
        });
    };

    const filteredRecords = computed(() => {
      return records.value.filter((record) =>
        props.displayColumns.some((column) =>
          String(record[column])
            .toLowerCase()
            .includes(search.value.toLowerCase())
        )
      );
    });

    const openDetailDialog = (record) => {
      detailedRecord.value = record;
      detailDialog.value = true;
    };

    const openEditDialog = (record) => {
      // alert(record.id);
      // Create a query object for the route
      const query = {
        tableName: props.deleteTableName,
        excludeColumns: JSON.stringify(props.excludeColumns),
        recordId: record.id,
      };

      // Use router to navigate to the edit route with the query
      router.push({ name: props.updatePath, query: query });
    };

    const deleteRecord = async (id) => {
      try {
        const response = await axios.post(window.SERVER_URL + "MassDelete", {
          TableName: props.deleteTableName,
          id: id,
        });

        if (response.data.error_a) {
          Swal.fire({
            title: "Error!",
            text: response.data.error_a,
            icon: "error",
            confirmButtonText: "OK",
          });
        } else {
          Swal.fire({
            title: "Success!",
            text: "Record deleted successfully",
            icon: "success",
            confirmButtonText: "OK",
          });
          fetchData(); // Refresh data after a successful deletion
        }
      } catch (error) {
        Swal.fire({
          title: "Error!",
          text: "Failed to delete the record",
          icon: "error",
          confirmButtonText: "OK",
        });
      }
    };

    const confirmDelete = (id) => {
      Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!",
      }).then((result) => {
        if (result.isConfirmed) {
          deleteRecord(id);
        }
      });
    };

    const getRandomIcon = () => {
      const icons = ["mdi-office-building", "mdi-home", "mdi-account"];
      return icons[Math.floor(Math.random() * icons.length)];
    };

    const getDisplayName = (record, columnName) => {
      return record[props.columnMapping[columnName] || columnName];
    };

    const formatLabel = (label) => {
      return (
        label.charAt(0).toUpperCase() +
        label
          .slice(1)
          .replace(/([A-Z])/g, " $1")
          .trim()
      );
    };

    onMounted(fetchData);

    return {
      records,
      search,
      detailedRecord,
      detailDialog,
      filteredRecords,
      openDetailDialog,
      confirmDelete,
      getRandomIcon,
      getDisplayName,
      formatLabel,
      isEditDialogOpen,
      selectedRecordId,
      openEditDialog,
      submitForm,
      deleteRecord,
    };
  },
};
</script>

<style scoped>
.search-bar {
  max-width: 600px;
}

.v-card-title,
.v-card-text {
  font-size: 1rem;
}

.v-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.acrylic {
  backdrop-filter: blur(10px); /* Fluent Design Acrylic Effect */
  background-color: white; /* For Light Mode */
}

.dark .acrylic {
  background-color: rgba(0, 0, 0, 0.7); /* For Dark Mode */
}

.black-divider {
  background-color: #000; /* Black Divider */
}

.v-list-item:hover {
  background-color: rgba(0, 0, 0, 0.1); /* Hover Effect */
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.primary--text {
  font-weight: bold;
  color: #6200ea; /* Vibrant Primary Color */
}

/* Base Layout */
.bg-grey-lighten-2 {
  background: linear-gradient(135deg, #f6f8fa 0%, #e9eff5 100%);
}

/* Search Bar */
.v-text-field--outlined .v-input__control {
  border-radius: 25px;
}

/* Card Styling */
.record-card {
  transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
  border-radius: 16px;
  overflow: hidden;
  background: white; /* Fluent Design: Consider Acrylic Effect */
  border: 1px solid rgba(0, 0, 0, 0.12);
}

.elevate-card {
  transform: scale(1.05);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
}

/* Dialog Transitions */
.dialog-bottom-transition-enter-active,
.dialog-bottom-transition-leave-active {
  transition: all 0.5s cubic-bezier(0.25, 0.8, 0.25, 1);
}
.dialog-bottom-transition-enter,
.dialog-bottom-transition-leave-to {
  transform: translateY(100%);
  opacity: 0;
}

/* Dialog Styling */
.detail-dialog,
.edit-dialog {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(15px); /* iOS-like blur effect */
}

.dialog-title {
  font-size: 2em;
  font-weight: bold;
  color: #424242;
  padding: 20px 30px;
  border-bottom: 1px solid rgba(0, 0, 0, 0.12);
}

.dialog-content {
  padding: 20px 30px;
}

/* Buttons */
.v-btn {
  border-radius: 50px;
  text-transform: none;
  font-weight: 600;
}

/* Custom Colors */
.primary--text,
.v-btn--color-primary {
  color: #007bff; /* iOS Blue */
}

.v-btn--color-secondary {
  color: #5c6bc0; /* iOS Indigo */
}

.v-btn--color-error {
  color: #ff3b30; /* iOS Red */
}

/* Pulse Effect on Button Click */
.v-btn:active {
  animation: pulse-animation 0.4s ease;
}

@keyframes pulse-animation {
  0% {
    transform: scale(0.95);
  }
  70% {
    transform: scale(1.05);
    opacity: 0.7;
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}

/* Hover Effect on Icons */
.v-icon:hover {
  animation: rotate-animation 0.7s ease-in-out;
}

@keyframes rotate-animation {
  0% {
    transform: rotate(0deg);
  }
  50% {
    transform: rotate(180deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

/* 3D Tilt Effect on Card Hover */
.record-card:hover {
  transform: perspective(1000px) rotateY(10deg);
  box-shadow: 0 20px 30px rgba(0, 0, 0, 0.25);
}

/* Spinner for Loading Data */
.loading-spinner {
  display: none;
}

.is-loading .loading-spinner {
  display: block;
  animation: spin-animation 1s linear infinite;
}

@keyframes spin-animation {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

/* Responsive Card Columns */
@media (max-width: 768px) {
  .v-col {
    flex: 0 0 100%;
    max-width: 100%;
  }
}

/* Responsive Fullscreen Dialogs */
@media (max-width: 480px) {
  .detail-dialog,
  .edit-dialog {
    padding: 10px;
  }

  .dialog-title {
    font-size: 1.5em;
  }

  .dialog-content {
    padding: 10px;
  }
}

/* Dynamic Text Scaling for Different Screen Sizes */
html {
  font-size: 16px;
}

@media (max-width: 1200px) {
  html {
    font-size: 15px;
  }
}

@media (max-width: 992px) {
  html {
    font-size: 14px;
  }
}

@media (max-width: 768px) {
  html {
    font-size: 13px;
  }
}

@media (max-width: 576px) {
  html {
    font-size: 12px;
  }
}
</style>
