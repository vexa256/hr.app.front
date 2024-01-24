<template>
  <div>
    <v-row>
      <!-- Iterate through non-textarea fields first -->
      <v-col
        v-for="(field, index) in fields"
        :key="index"
        cols="12"
        sm="6"
        md="4"
        class="field-container"
      >
        <!-- Text or Number Field -->
        <v-text-field
          v-if="
            field.component === 'v-text-field' ||
            field.component === 'v-number-field'
          "
          v-model="field.model"
          :label="formatLabel(field.name)"
          :name="field.name"
          :type="field.component === 'v-number-field' ? 'number' : 'text'"
          dense
          outlined
          clearable
          :prepend-icon="field.icon"
        />

        <!-- Vuetify-Styled Native Date Field -->
        <div
          v-else-if="field.component === 'date'"
          class="date-picker-container"
        >
          <label :for="field.name">{{ formatLabel(field.name) }}</label>
          <input
            type="date"
            :id="field.name"
            :name="field.name"
            v-model="field.model"
            class="vuetify-date-input"
          />
        </div>

        <!-- Other field types as necessary -->
      </v-col>
      <v-col
        v-for="(field, index) in fields"
        :key="index"
        cols="12"
        sm="12"
        md="12"
        class="field-container"
      >
        <!-- TextArea for Text and LongText -->
        <v-textarea
          v-if="field.component === 'v-textarea'"
          v-model="field.model"
          :label="formatLabel(field.name)"
          :name="field.name"
          auto-grow
          outlined
          clearable
          :prepend-icon="field.icon"
        />
      </v-col>
    </v-row>

    <!-- Separate row for v-textarea fields -->

    <input type="hidden" name="TableName" :value="tableName" />
    <input type="hidden" name="id" :value="recordId" />
  </div>
</template>

<script>
import { ref, onMounted } from "vue";
import axios from "axios";

export default {
  name: "FormEngine",
  props: {
    tableName: String,
    excludeColumns: Array,
    recordId: Number, // Added recordId prop for populating the form with record data
  },
  setup(props) {
    const fields = ref([]);

    const fetchData = async () => {
      try {
        if (props.recordId) {
          // Fetch the specific record by ID
          const response = await axios.post(
            `${window.SERVER_URL}fetchRecordById`,
            {
              TableName: props.tableName,
              id: props.recordId,
            }
          );
          const data = response.data;

          // Log excluded columns
          console.log("Excluded Columns:", props.excludeColumns);

          // Remove excluded columns from the fetched data
          const filteredColumns = Object.fromEntries(
            Object.entries(data.columns).filter(
              ([columnName]) => !props.excludeColumns.includes(columnName)
            )
          );

          // Create form fields based on columns and exclude "id" field from form
          const columnsWithoutId = Object.entries(filteredColumns).filter(
            ([columnName]) => columnName !== "id"
          );
          createFormFields(Object.fromEntries(columnsWithoutId), data.data);
        } else {
          const response = await axios.post(
            `${window.SERVER_URL}GlobalDataFetcher`,
            { TableName: props.tableName, ExcludeColumns: props.excludeColumns }
          );
          createFormFields(response.data.columns);
        }
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    const createFormFields = (columns, recordData = {}) => {
      fields.value = Object.entries(columns).map(([columnName, columnType]) => {
        return {
          name: columnName,
          model: recordData[columnName] || "", // Populate with record data if available
          component: determineComponent(columnType),
          icon: getRandomIcon(),
        };
      });
    };

    const determineComponent = (type) => {
      if (
        type.includes("decimal") ||
        type.includes("number") ||
        type.includes("int")
      ) {
        return "v-number-field";
      } else if (type.includes("date")) {
        return "date";
      } else if (type.includes("text") || type.includes("longtext")) {
        return "v-textarea";
      }
      return "v-text-field";
    };

    const getRandomIcon = () => {
      return window.icons[Math.floor(Math.random() * window.icons.length)];
    };

    const formatLabel = (label) => {
      return label
        .replace(/([A-Z])/g, " $1")
        .replace(/^./, (str) => str.toUpperCase())
        .trim();
    };

    onMounted(fetchData);

    return {
      fields,
      formatLabel,
      getRandomIcon,
    };
  },
};
</script>

<style scoped>
.vuetify-date-input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ced4da;
  border-radius: 4px;
  font-size: 16px;
}

.date-picker-container {
  display: flex;
  flex-direction: column;
}

.date-picker-container label {
  margin-bottom: 5px;
  font-size: 12px;
  color: #616161; /* Vuetify's label color */
}
.field-container {
  margin-bottom: 20px;
}

.v-text-field {
  transition: box-shadow 0.2s ease-in-out;
  &:hover {
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
  }
}

.v-text-field--outlined .v-input__control {
  transition: border-color 0.2s ease-in-out;
}

.v-text-field--outlined .v-input__control:hover {
  border-color: var(--v-primary-base);
}

.v-input__prepend-inner .v-icon {
  transition: transform 0.3s ease-in-out;
}

.v-text-field--outlined .v-input__prepend-inner .v-icon:hover {
  transform: scale(1.1);
}

.vuetify-date-input {
  width: 100%;
  border: none;
  outline: none;
  background: transparent;
  padding: 8px 0;
  font-size: inherit;
  cursor: pointer;
}

/* Style for read-only text fields to match other fields */
.v-text-field--outlined.read-only {
  background-color: #f5f5f5;
}

/* Button Styling */
.v-btn {
  transition: background-color 0.2s, box-shadow 0.2s;
  &:hover {
    background-color: var(--v-primary-darken-1);
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
  }
}

/* Additional styles as per your application's theme */
</style>
