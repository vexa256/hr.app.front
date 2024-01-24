<template>
  <v-app id="inspire">
    <v-app-bar app color="white" elevate-on-scroll>
      <!-- Back Button -->
      <v-btn icon @click="goBack">
        <v-icon>mdi-arrow-left</v-icon>
      </v-btn>

      <v-app-bar-title class="text-uppercase grey--text">
        <v-icon large class="mr-2 app-bar-icon">mdi-office-building</v-icon>
        <span class="app-bar-title">Department Management</span>
      </v-app-bar-title>

      <v-spacer></v-spacer>

      <v-btn icon @click="openAddDepartmentDialog">
        <v-icon>mdi-plus</v-icon>
      </v-btn>

      <!-- Refresh Button -->
      <v-btn icon @click="refreshPage">
        <v-icon>mdi-refresh</v-icon>
      </v-btn>
    </v-app-bar>

    <v-main class="bg-grey-lighten-2">
      <v-container>
        <v-row>
          <v-col cols="12">
            <v-text-field
              v-model="search"
              label="Search Departments"
              dense
              outlined
              append-outer-icon="mdi-magnify"
              class="search-bar"
              clearable
            ></v-text-field>
          </v-col>

          <v-col
            v-for="department in filteredDepartments"
            :key="department.id"
            cols="12"
            md="4"
          >
            <v-hover v-slot:default="{ hover }">
              <v-card
                :class="getCardClass(department)"
                :elevation="hover ? 12 : 2"
              >
                <v-card-title>
                  <v-icon :color="getIconColor(department)">{{
                    getRandomIcon()
                  }}</v-icon>
                  {{ department.DepartmentName }}
                </v-card-title>
                <v-card-text>{{ department.Description }}</v-card-text>
                <v-card-actions>
                  <v-btn text color="blue" @click="openDetailDialog(department)"
                    >View</v-btn
                  >
                  <v-btn
                    text
                    color="green"
                    @click="openAddEditDialog(department)"
                    >Edit</v-btn
                  >
                  <v-btn
                    text
                    color="red"
                    @click="deleteDepartment(department.id)"
                    >Delete</v-btn
                  >
                </v-card-actions>
              </v-card>
            </v-hover>
          </v-col>
        </v-row>

        <v-dialog v-model="addDepartmentDialog" max-width="500px">
          <v-card>
            <v-card-title class="headline">Add Department</v-card-title>
            <v-card-text>
              <v-form @submit.prevent="submitForm">
                <v-text-field
                  v-model="newDepartment.DepartmentName"
                  label="Department Name"
                  required
                ></v-text-field>
                <v-textarea
                  v-model="newDepartment.Description"
                  label="Description"
                  required
                ></v-textarea>
                <v-text-field
                  v-model="newDepartment.DID"
                  label="DID"
                  readonly
                ></v-text-field>
                <v-btn color="blue darken-1" type="submit">Save</v-btn>
                <v-btn color="grey darken-1" @click="closeAddDepartmentDialog"
                  >Cancel</v-btn
                >
              </v-form>
            </v-card-text>
          </v-card>
        </v-dialog>

        <!-- Department Detail Dialog -->
        <v-dialog v-model="detailDialog" max-width="500px">
          <v-card>
            <v-card-title class="headline">Department Details</v-card-title>
            <v-card-text>
              <div>
                <strong>Name:</strong> {{ detailedDepartment.DepartmentName }}
              </div>
              <div>
                <strong>Description:</strong>
                {{ detailedDepartment.Description }}
              </div>
            </v-card-text>
            <v-card-actions>
              <v-btn color="grey darken-1" text @click="detailDialog = false"
                >Close</v-btn
              >
            </v-card-actions>
          </v-card>
        </v-dialog>

        <!-- Edit Department Dialog -->
        <v-dialog v-model="addEditDialog" max-width="500px">
          <v-card>
            <v-card-title class="headline"
              >{{
                currentDepartment.id ? "Edit" : "Add"
              }}
              Department</v-card-title
            >
            <v-card-text>
              <v-text-field
                v-model="currentDepartment.DepartmentName"
                label="Department Name"
                required
              ></v-text-field>
              <v-textarea
                v-model="currentDepartment.Description"
                label="Description"
                required
              ></v-textarea>
              <v-text-field
                v-model="currentDepartment.DID"
                label="DID"
                readonly
              ></v-text-field>
            </v-card-text>
            <v-card-actions>
              <v-btn color="blue darken-1" text @click="saveDepartment"
                >Save</v-btn
              >
              <v-btn color="grey darken-1" text @click="closeAddEditDialog"
                >Cancel</v-btn
              >
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import axios from "axios";
import { useRouter } from "vue-router";
import Swal from "sweetalert2";

export default {
  data() {
    return {
      departments: [],
      search: "",
      detailedDepartment: {},
      currentDepartment: {},
      addEditDialog: false,
      detailDialog: false,
      icons: window.icons,
      addDepartmentDialog: false,

      newDepartment: {
        DepartmentName: "",
        Description: "",
        DID: "",
      },
    };
  },
  computed: {
    filteredDepartments() {
      const searchTerm = this.search.toLowerCase();
      return this.departments.filter((department) => {
        return (
          department.DepartmentName.toLowerCase().includes(searchTerm) ||
          department.Description.toLowerCase().includes(searchTerm)
        );
      });
    },
  },
  methods: {
    openAddDepartmentDialog() {
      this.newDepartment = {
        DepartmentName: "",
        Description: "",
        DID: this.generateRandomDID(),
      };
      this.addDepartmentDialog = true;
    },
    closeAddDepartmentDialog() {
      this.addDepartmentDialog = false;
    },
    generateRandomDID() {
      const characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
      let did = "";
      for (let i = 0; i < 9; i++) {
        const randomIndex = Math.floor(Math.random() * characters.length);
        did += characters.charAt(randomIndex);
      }
      return did;
    },
    submitForm() {
      if (
        !this.newDepartment.DepartmentName ||
        !this.newDepartment.Description ||
        !this.newDepartment.DID
      ) {
        Swal.fire("Error", "Please fill in all fields", "error");
        return;
      }

      axios
        .post(window.SERVER_URL + "MassInsert", {
          TableName: "departments",
          ...this.newDepartment,
        })
        .then(() => {
          Swal.fire("Success", "Department added successfully", "success");
          this.closeAddDepartmentDialog();
          this.$emit("department-added");
          this.fetchData();
        })
        .catch((error) => {
          console.error("Error adding department:", error);
          Swal.fire("Error", "Failed to add department", "error");
        });
    },

    saveDepartment() {
      if (
        !this.currentDepartment.DepartmentName ||
        !this.currentDepartment.Description ||
        !this.currentDepartment.DID
      ) {
        Swal.fire("Error", "Please fill in all fields", "error");
        return;
      }

      const apiUrl = this.currentDepartment.id
        ? window.SERVER_URL + "MassUpdate"
        : window.SERVER_URL + "MassInsert";

      axios
        .post(apiUrl, {
          ...this.currentDepartment,
          TableName: "departments",
        })
        .then(() => {
          Swal.fire("Success", "Department saved successfully", "success");
          this.fetchData();
        })
        .catch((error) => {
          console.error("Error saving department:", error);
          Swal.fire("Error", "Failed to save department", "error");
        })
        .finally(() => {
          this.addEditDialog = false;
        });
    },
    openAddEditDialog(department = { DepartmentName: "", Description: "" }) {
      this.currentDepartment = department;
      this.addEditDialog = true;
    },
    closeAddEditDialog() {
      this.addEditDialog = false;
    },

    deleteDepartment(id) {
      if (!id) {
        Swal.fire("Error", "Department ID is empty", "error");
        return;
      }

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
          axios
            .post(window.SERVER_URL + "MassDelete", {
              TableName: "departments",
              id: id,
            })
            .then(() => {
              Swal.fire(
                "Success",
                "Department deleted successfully",
                "success"
              );
              this.fetchData();
            })
            .catch((error) => {
              console.error("Error deleting department:", error);
              Swal.fire("Error", "Failed to delete department", "error");
            });
        }
      });
    },

    openDetailDialog(department) {
      this.detailedDepartment = department;
      this.detailDialog = true;
    },
    fetchData() {
      axios
        .post(window.SERVER_URL + "GlobalDataFetcher", {
          TableName: "departments",
          ExcludeColumns: ["created_at", "updated_at"],
        })
        .then((response) => {
          this.departments = response.data.data;
        })
        .catch((error) => {
          console.error("Error fetching data:", error);
          Swal.fire("Error", "Failed to fetch data", "error");
        });
    },
    getRandomIcon() {
      const randomIndex = Math.floor(Math.random() * this.icons.length);
      return this.icons[randomIndex];
    },
    getCardClass(department) {
      // Logic to assign a dynamic class to each card based on department properties
      // For example, use department attributes to determine the color or style of the card
    },
    getIconColor(department) {
      // Logic to assign a color to the icon based on department properties
      // This could be based on the department type, size, or other characteristics
    },
  },
  created() {
    this.fetchData();
  },

  setup() {
    const router = useRouter();

    const goBack = () => {
      router.back();
    };

    const refreshPage = () => {
      router.go(0);
    };

    return { goBack, refreshPage };
  },
};
</script>

<style scoped>
.search-bar {
  max-width: 600px;
}

.v-app-bar {
  color: white;
  background-color: #1976d2;
}

.v-btn {
  transition: all 0.3s ease;
}

.v-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.v-icon {
  transition: all 0.2s ease;
}

.v-icon:hover {
  color: #ff4081;
}

.app-bar-icon {
  animation: icon-rotation 3s infinite linear;
  color: #5c6bc0; /* Custom Icon color */
}

.app-bar-title {
  letter-spacing: 1px;
  animation: fadeIn 2s ease-in;
}

@keyframes icon-rotation {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.app-bar-icon,
.v-btn {
  animation: icon-animation 2s infinite linear;
}

/* Additional styles for a futuristic look */
.v-app-bar {
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
  border-bottom: 1px solid #e0e0e0;
}
/* Add custom styles for card classes */
/* Example:
.card-style-1 { ... }
.card-style-2 { ... }
...
*/
</style>
