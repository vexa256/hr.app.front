<template>
  <div>
    <v-row>
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

        <!-- TextArea for Text and LongText -->
        <v-textarea
          v-else-if="field.component === 'v-textarea'"
          v-model="field.model"
          :label="formatLabel(field.name)"
          :name="field.name"
          auto-grow
          outlined
          clearable
          :prepend-icon="field.icon"
        />

        <!-- Vuetify-Styled Native Date Field -->
        <div
          v-else-if="field.component === 'date'"
          class="date-picker-container"
        >
          <label class="me-2" :for="field.name">{{
            formatLabel(field.name)
          }}</label>
          <input
            dense
            outlined
            style="border: 10px"
            type="date"
            :id="field.name"
            :name="field.name"
            v-model="field.model"
            class="vuetify-date-input v-text-field v-field__input"
          />
        </div>

        <!-- Other field types as necessary -->
      </v-col>
    </v-row>
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
  },
  setup(props) {
    const fields = ref([]);

    const fetchData = async () => {
      try {
        const response = await axios.post(
          `${window.SERVER_URL}GlobalDataFetcher`,
          {
            TableName: props.tableName,
            ExcludeColumns: props.excludeColumns,
          }
        );
        const data = response.data;
        createFormFields(data.columns);
      } catch (error) {
        console.error("Error fetching table schema:", error);
      }
    };

    const createFormFields = (columns) => {
      fields.value = Object.entries(columns).map(([columnName, columnType]) => {
        return {
          name: columnName,
          model: "",
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
