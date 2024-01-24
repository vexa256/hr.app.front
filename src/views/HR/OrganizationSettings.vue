<template>
  <div>
    <v-row>
      `<v-col cols="12" sm="6">
        <v-text-field
          v-model="search"
          label="Search employees"
          prepend-icon="mdi-magnify"
          clearable
          solo
          dense
          outlined
        ></v-text-field>
      </v-col>
      <v-col cols="12" sm="6" class="d-flex justify-end">
        <v-btn color="primary" class="mx-2" @click="showDepartmentModal">
          <v-icon left>mdi-office-building</v-icon>
          Departments
        </v-btn>
        <v-btn color="primary" @click="showPositionModal">
          <v-icon left>mdi-briefcase-outline</v-icon>
          Positions
        </v-btn>
      </v-col>
    </v-row>

  </div>
</template>
<script>
import { ref } from 'vue';
// import EmployeeTable from './EmployeeTable.vue';

export default {
  name: "EmployeeManagement",
  components: {
    // 'employee-table': EmployeeTable,
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
