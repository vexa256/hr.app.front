<template>
  <div>
    <v-app-bar app color="white" elevate-on-scroll>
      <!-- Back Button -->
      <v-btn icon @click="$router.back()">
        <v-icon>mdi-arrow-left</v-icon>
      </v-btn>

      <v-app-bar-title>
        <v-icon class="me-5">mdi-cog</v-icon> Update Payroll Labels
      </v-app-bar-title>

      <v-spacer></v-spacer>

      <!-- <v-btn icon @click="toggleDialog">
        <v-icon>mdi-plus</v-icon>
      </v-btn> -->

      <router-link :to="{ name: 'Loader' }">
        <v-btn icon>
          <v-icon>mdi-refresh</v-icon>
        </v-btn>
      </router-link>
    </v-app-bar>

    <!-- Main Content Area -->
    <v-container fluid>
      <v-card class="elevate-3">
        <v-card-text>
          <v-row>
            <v-col cols="12">
              <v-container>
                <v-row>
                  <v-col cols="12">
                    <form @submit.prevent="submitForm" id="UpdateRecordForm">
                      <v-card-actions class="justify-end">
                        <!-- Action Buttons -->
                        <v-btn color="primary" type="submit">
                          <v-icon left>mdi-content-save</v-icon> Save
                        </v-btn>
                        <v-btn color="red" text @click="cancelUpdate">
                          <v-icon left>mdi-cancel</v-icon> Cancel
                        </v-btn>
                      </v-card-actions>
                      <!-- <GlobalSelect
                        TableName="projects"
                        idField="ProjectID"
                        nameField="ProjectName"
                        :ExcludeColumns="['created_at', 'updated_at']"
                        label="Select Parent Project"
                      /> -->
                      <!-- Form Content -->
                      <record-form-engine
                        :tableName="tableName"
                        :exclude-columns="excludeColumns"
                        :record-id="selectedRecordId"
                        ref="recordForm"
                      ></record-form-engine>
                      <!-- <v-btn color="primary" type="submit">
                        Update Record
                      </v-btn> -->
                    </form>
                  </v-col>
                </v-row>
              </v-container>
            </v-col>
          </v-row>
        </v-card-text>
      </v-card>
    </v-container>
  </div>
</template>

<script>
import RecordFormEngine from "@/utils/UpdateEngine.vue";
import axios from "axios";
import Swal from "sweetalert2";
import GlobalSelect from "@/utils/GlobalSelect";

export default {
  components: {
    GlobalSelect,
    RecordFormEngine,
  },
  data() {
    return {
      tableName: "", // Initially empty, to be set from URL parameters
      excludeColumns: [], // Initially empty, to be set from URL parameters
      selectedRecordId: null, // Initially null, to be set from URL parameters
    };
  },
  async created() {
    const routeQuery = this.$route.query;

    // Set the data properties from the URL query parameters
    this.tableName = routeQuery.tableName || "defaultTableName";
    this.excludeColumns = routeQuery.excludeColumns
      ? JSON.parse(routeQuery.excludeColumns)
      : ["created_at", "updated_at"];
    this.selectedRecordId = routeQuery.recordId || null;
  },
  methods: {
    async submitForm() {
      // Validate the form fields
      const form = document.getElementById("UpdateRecordForm");
      const formData = new FormData(form);

      // Add TableName to the FormData
      formData.append("TableName", this.tableName);

      const emptyFields = [];
      for (const [field, value] of formData.entries()) {
        if (!value) {
          emptyFields.push(field);
        }
      }

      if (emptyFields.length > 0) {
        // Display Swal notification for empty fields
        Swal.fire({
          title: "Error!",
          html: `The following fields are empty:<br>${emptyFields.join(
            "<br>"
          )}`,
          icon: "error",
          confirmButtonText: "OK",
        });
        return;
      }

      try {
        const response = await axios.post(
          window.SERVER_URL + "MassUpdate",
          formData
        );

        if (response.data.error_a) {
          // Display Swal error message
          Swal.fire({
            title: "Error!",
            text: response.data.error_a,
            icon: "error",
            confirmButtonText: "OK",
          });
        } else {
          // Display Swal success message
          Swal.fire({
            title: "Success!",
            text: "Your changes have been saved successfully",
            icon: "success",
            confirmButtonText: "OK",
          });

          // Navigate back to the previous page after a successful update
          this.$router.go(-1);
        }
      } catch (error) {
        // Display Swal error message for any other errors
        Swal.fire({
          title: "Error!",
          text: error.message,
          icon: "error",
          confirmButtonText: "OK",
        });
      }
    },
    cancelUpdate() {
      // Navigate back to the previous page when Cancel is clicked
      this.$router.go(-1);
    },
  },
};
</script>
