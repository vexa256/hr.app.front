<template>
  <div class="v-input__control">
    <div
      class="v-field v-field--center-affix v-field--variant-filled v-theme--light v-locale--is-ltr"
    >
      <div class="v-field__overlay"></div>

      <!-- Input Field -->
      <div class="v-field__field" data-no-activator="">
        <label
          class="v-label v-field-label v-field-label--floating"
          aria-hidden="true"
        >
          Search Department
        </label>
        <input
          type="text"
          v-model="search"
          @input="filterDepartments"
          @focus="dropdownVisible = true"
          @blur="hideDropdown"
          class="v-field__input vuetify-input"
          placeholder="Search Department"
        />
      </div>

      <!-- Dropdown List -->
      <ul
        v-if="dropdownVisible && filteredDepartments.length"
        class="autocomplete-results"
      >
        <li
          v-for="department in filteredDepartments"
          :key="department.DID"
          @click="selectDepartment(department)"
        >
          {{ department.DepartmentName }}
        </li>
      </ul>

      <input type="hidden" name="DID" :value="selectedDepartmentDID" />
    </div>
  </div>
</template>

<script>
import { ref, watch } from "vue";
import axios from "axios";

export default {
  setup() {
    const search = ref("");
    const departments = ref([]);
    const filteredDepartments = ref([]);
    const selectedDepartmentDID = ref("");
    const dropdownVisible = ref(false);

    // Fetch departments from the server
    const fetchDepartments = async () => {
      try {
        const response = await axios.post(
          `${window.SERVER_URL}GlobalDataFetcher`,
          { TableName: "departments" }
        );
        departments.value = response.data.data;
      } catch (error) {
        console.error("Error fetching departments:", error);
      }
    };

    // Filter departments based on the search input
    watch(search, () => {
      if (search.value) {
        filteredDepartments.value = departments.value.filter((department) =>
          department.DepartmentName.toLowerCase().includes(
            search.value.toLowerCase()
          )
        );
      } else {
        filteredDepartments.value = [];
      }
    });

    // Select a department from the dropdown
    const selectDepartment = (department) => {
      search.value = department.DepartmentName;
      selectedDepartmentDID.value = department.DID;
      dropdownVisible.value = false;
    };

    // Hide the dropdown after a delay
    const hideDropdown = () => {
      setTimeout(() => {
        dropdownVisible.value = false;
      }, 200);
    };

    fetchDepartments();

    return {
      search,
      filteredDepartments,
      selectDepartment,
      selectedDepartmentDID,
      dropdownVisible,
    };
  },
};
</script>

<style>
.autocomplete {
  position: relative;
  width: 100%;
  max-width: 400px; /* Adjust the width as needed */
  margin: 0 auto;
}

.vuetify-input {
  width: 100%;
  padding: 10px 15px;
  font-size: 1rem;
  border: 1px solid #ced4da;
  border-radius: 4px;
  box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
  transition: border-color 0.2s, box-shadow 0.2s;
}

.vuetify-input:focus {
  border-color: #80bdff;
  box-shadow: 0px 2px 8px rgba(0, 123, 255, 0.25);
  outline: none;
}

.autocomplete-results {
  position: absolute;
  width: 100%;
  border: 1px solid #ced4da;
  border-top: none;
  list-style: none;
  padding: 0;
  margin: 0;
  z-index: 1000;
  background-color: #fff;
  max-height: 200px;
  overflow-y: auto;
  border-bottom-left-radius: 4px;
  border-bottom-right-radius: 4px;
  box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
}

.autocomplete-results li {
  padding: 10px 15px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.autocomplete-results li:hover {
  background-color: #f8f9fa;
}

.autocomplete-results li:not(:last-child) {
  border-bottom: 1px solid #eaecef;
}
</style>
