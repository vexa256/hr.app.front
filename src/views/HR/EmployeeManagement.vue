<template>
  <v-container fluid>
    <!-- Search and Filter Panel -->
    <v-row>
      <!-- `<v-col cols="12" sm="6">
        <v-text-field
          v-model="search"
          label="Search employees"
          prepend-icon="mdi-magnify"
          clearable
          solo
          dense
          outlined
        ></v-text-field>
      </v-col>` -->
      <!-- <v-col cols="12" sm="6" class="d-flex justify-end">
        <v-btn color="primary" class="mx-2" @click="showDepartmentModal">
          <v-icon left>mdi-office-building</v-icon>
          Departments
        </v-btn>
        <v-btn color="primary" @click="showPositionModal">
          <v-icon left>mdi-briefcase-outline</v-icon>
          Positions
        </v-btn>
      </v-col> -->
    </v-row>

    <!-- Employee Data Table -->
    <employee-table :search="search"></employee-table>

    <!-- Department Management Modal -->
    <v-dialog v-model="departmentModal" persistent max-width="800px">
      <v-card>
        <v-card-title>Departments</v-card-title>
        <v-card-text>
          <v-form ref="departmentForm" v-model="validDepartment">
            <input type="hidden" name="TableName" value="departments">
            <input type="hidden" v-model="currentDepartment.DID">
            <v-text-field v-model="currentDepartment.DepartmentName" label="Department Name" required></v-text-field>
            <v-text-field v-model="currentDepartment.Description" label="Description" required></v-text-field>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-btn color="primary" @click="saveDepartment">Save</v-btn>
      2    <v-btn color="grey" text @click="departmentModal = false">Cancel</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <!-- Position Management Modal -->
    <v-dialog v-model="positionModal" persistent max-width="800px">
      <v-card>
        <v-card-title>Positions</v-card-title>
        <v-card-text>
          <v-form ref="positionForm" v-model="validPosition">
            <input type="hidden" name="TableName" value="positions">
            <input type="hidden" v-model="currentPosition.PID">
            <v-text-field v-model="currentPosition.Position" label="Position Title" required></v-text-field>
            <v-text-field v-model="currentPosition.Description" label="Description" required></v-text-field>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-btn color="primary" @click="savePosition">Save</v-btn>
          <v-btn color="grey" text @click="positionModal = false">Cancel</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import { ref } from 'vue';
import EmployeeTable from './EmployeeTable.vue';

export default {
  name: "EmployeeManagement",
  components: {
    'employee-table': EmployeeTable,
  },
  setup() {
    const search = ref("");
    const departmentModal = ref(false);
    const positionModal = ref(false);
    const currentDepartment = ref({ DepartmentName: "", Description: "", DID: "" });
    const currentPosition = ref({ Position: "", Description: "", PID: "" });
    const validDepartment = ref(false);
    const validPosition = ref(false);

    const showDepartmentModal = () => {
      departmentModal.value = true;
    };

    const showPositionModal = () => {
      positionModal.value = true;
    };

    const saveDepartment = async () => {
      if (validDepartment.value) {
        // Implement your save logic here
        closeDepartmentModal();
      }
    };

    const savePosition = async () => {
      if (validPosition.value) {
        // Implement your save logic here
        closePositionModal();
      }
    };

    const closeDepartmentModal = () => {
      departmentModal.value = false;
    };

    const closePositionModal = () => {
      positionModal.value = false;
    };

    return {
      search,
      departmentModal,
      positionModal,
      currentDepartment,
      currentPosition,
      validDepartment,
      validPosition,
      showDepartmentModal,
      showPositionModal,
      saveDepartment,
      savePosition,
      closeDepartmentModal,
      closePositionModal,
    };
  },
};
</script>
