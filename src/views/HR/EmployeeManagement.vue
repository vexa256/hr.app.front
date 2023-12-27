<template>
  <v-container fluid>
    <!-- Search and Filter Panel -->
    <v-row>
      <v-col cols="12" sm="6">
        <v-text-field
          v-model="search"
          label="Search employees"
          prepend-icon="mdi-magnify"
          clearable
          @input="fetchData"
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

    <!-- Employee Data Table -->
    <v-data-table
      :headers="employeeHeaders"
      :items="employees"
      :search="search"
      class="elevation-1"
    >
      <template v-slot:item.action="{ item }">
        <v-icon small class="mr-2" @click="editEmployee(item)">mdi-pencil</v-icon>
        <v-icon small color="red" @click="deleteEmployee(item)">mdi-delete</v-icon>
      </template>
    </v-data-table>

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
          <v-data-table
            :headers="departmentHeaders"
            :items="departments"
            class="mt-4"
          >
            <template v-slot:item.action="{ item }">
              <v-icon small class="mr-2" @click="editDepartment(item)">mdi-pencil</v-icon>
              <v-icon small color="red" @click="deleteDepartment(item)">mdi-delete</v-icon>
            </template>
          </v-data-table>
        </v-card-text>
        <v-card-actions>
          <v-btn color="primary" @click="saveDepartment">Save</v-btn>
          <v-btn color="grey" text @click="departmentModal = false">Cancel</v-btn>
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
          <v-data-table
            :headers="positionHeaders"
            :items="positions"
            class="mt-4"
          >
            <template v-slot:item.action="{ item }">
              <v-icon small class="mr-2" @click="editPosition(item)">mdi-pencil</v-icon>
              <v-icon small color="red" @click="deletePosition(item)">mdi-delete</v-icon>
            </template>
          </v-data-table>
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
import axios from 'axios';
import Swal from 'sweetalert2';
import { ref, onMounted } from 'vue';

export default {
  name: "EmployeeManagement",
  setup() {
    const search = ref("");
    const employees = ref([]);
    const departments = ref([]);
    const positions = ref([]);

    const departmentModal = ref(false);
    const positionModal = ref(false);
    const currentDepartment = ref({ DepartmentName: "", Description: "", DID: "" });
    const currentPosition = ref({ Position: "", Description: "", PID: "" });
    const validDepartment = ref(false);
    const validPosition = ref(false);

    const employeeHeaders = ref([
      { text: "Name", value: "Name" },
      { text: "UserID", value: "UserID" },
      { text: "EID", value: "EID" },
      { text: "SupervisorID", value: "SupervisorID" },
      { text: "Email", value: "Email" },
      { text: "PhoneNumber", value: "PhoneNumber" },
      { text: "DateOfBirth", value: "DateOfBirth" },
      { text: "Gender", value: "Gender" },
      { text: "Actions", value: "action", sortable: false }
    ]);

    const departmentHeaders = ref([
      { text: "Department Name", value: "DepartmentName" },
      { text: "Description", value: "Description" },
      { text: "DID", value: "DID" },
      { text: "Actions", value: "action", sortable: false }
    ]);

    const positionHeaders = ref([
      { text: "Position Title", value: "Position" },
      { text: "Description", value: "Description" },
      { text: "PID", value: "PID" },
      { text: "Actions", value: "action", sortable: false }
    ]);

    const fetchData = async () => {
      try {
        const employeesUrl = `${window.SERVER_URL}GetEmployees`;
        const departmentsUrl = `${window.SERVER_URL}GetDepartments`;
        const positionsUrl = `${window.SERVER_URL}GetPositions`;

        const employeeResponse = await axios.get(employeesUrl);
        employees.value = employeeResponse.data.data;

        const departmentResponse = await axios.get(departmentsUrl);
        departments.value = departmentResponse.data.data;

        const positionResponse = await axios.get(positionsUrl);
        positions.value = positionResponse.data.data;
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    const showDepartmentModal = () => {
      departmentModal.value = true;
    };

    const closeDepartmentModal = () => {
      departmentModal.value = false;
    };

    const saveDepartment = async () => {
      if (validDepartment.value) {
        await axios.post(`${window.SERVER_URL}api/PostDepartment`, currentDepartment.value);
        closeDepartmentModal();
        fetchData();
      }
    };

    const showPositionModal = () => {
      positionModal.value = true;
    };

    const closePositionModal = () => {
      positionModal.value = false;
    };

    const savePosition = async () => {
      if (validPosition.value) {
        await axios.post(`${window.SERVER_URL}api/PostPosition`, currentPosition.value);
        closePositionModal();
        fetchData();
      }
    };

    const editEmployee = (item) => {
      // TODO: Implement edit logic for Employee
    };

    const deleteEmployee = (item) => {
      // TODO: Implement delete logic for Employee
    };

    const editDepartment = (item) => {
      // TODO: Implement edit logic for Department
    };

    const deleteDepartment = (item) => {
      // TODO: Implement delete logic for Department
    };

    const editPosition = (item) => {
      // TODO: Implement edit logic for Position
    };

    const deletePosition = (item) => {
      // TODO: Implement delete logic for Position
    };

    onMounted(fetchData);

    return {
      search,
      employees,
      departments,
      positions,
      departmentModal,
      positionModal,
      currentDepartment,
      currentPosition,
      validDepartment,
      validPosition,
      employeeHeaders,
      departmentHeaders,
      positionHeaders,
      fetchData,
      showDepartmentModal,
      closeDepartmentModal,
      saveDepartment,
      showPositionModal,
      closePositionModal,
      savePosition,
      editEmployee,
      deleteEmployee,
      editDepartment,
      deleteDepartment,
      editPosition,
      deletePosition
    };
  },
};
</script>
