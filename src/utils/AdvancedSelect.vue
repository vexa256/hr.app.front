<template>
  <v-col :cols="cols" :md="mdSize" :lg="lgSize">
    <v-autocomplete
      v-model="selectedName"
      :items="itemNames"
      :label="label"
      prepend-icon="mdi-magnify"
      ref="autocompleteRef"
    ></v-autocomplete>
    <!-- Hidden form field for the selected ID -->
    <input type="hidden" :name="hiddenFieldName" v-model="selectedItemID" />
  </v-col>
</template>

<script>
import axios from "axios";

export default {
  props: {
    TableName: {
      type: String,
      required: true,
    },
    idField: {
      type: String,
      required: true,
    },
    hiddenFieldName: {
      type: String,
      required: false,
    },
    nameField: {
      type: String,
      required: true,
    },
    ExcludeColumns: {
      type: Array,
      default: () => [],
    },
    label: {
      type: String,
      default: "Select an item",
    },
    mdSize: {
      type: [String, Number],
      default: 4,
    },
    lgSize: {
      type: [String, Number],
      default: 4,
    },
    cols: {
      type: [String, Number],
      default: 12,
    },
  },
  data() {
    return {
      selectedItem: null,
      selectedItemID: null,
      itemNames: [],
      rawItems: [],
      selectedName: null,
    };
  },
  created() {
    this.fetchData();
  },
  methods: {
    fetchData() {
      const apiEndpoint = window.SERVER_URL + "GlobalDataFetcher";
      axios
        .post(apiEndpoint, {
          TableName: this.TableName,
          ExcludeColumns: this.ExcludeColumns,
        })
        .then((response) => {
          if (Array.isArray(response.data.data)) {
            this.rawItems = response.data.data;
            this.itemNames = this.rawItems.map(
              (item) => item[this.nameField] || ""
            );
          }
        })
        .catch((error) => {
          console.error("Error fetching data:", error);
        });
    },
    onSelection() {
      const selectedText = this.selectedName;
      const selectedItem = this.rawItems.find(
        (item) => item[this.nameField] === selectedText
      );
      this.selectedItem = selectedItem;
      this.selectedItemID = selectedItem ? selectedItem[this.idField] : null;
    },
  },
  watch: {
    selectedName() {
      this.onSelection();
    },
  },
};
</script>
