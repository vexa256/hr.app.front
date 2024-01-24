<template>
  <v-card :class="getCardClass(department)" :elevation="hover ? 12 : 2">
    <v-card-title>
      <v-icon :color="getIconColor(department)">{{ getRandomIcon() }}</v-icon>
      {{ department.DepartmentName }}
    </v-card-title>
    <v-card-text>{{ department.Description }}</v-card-text>
    <v-card-actions>
      <v-btn text color="blue" @click="openDetailDialog(department)"
        >View</v-btn
      >
      <v-btn text color="green" @click="openEditDialog(department)">Edit</v-btn>
      <v-btn text color="red" @click="deleteDepartment(department.id)"
        >Delete</v-btn
      >
    </v-card-actions>
  </v-card>
</template>

<script>
export default {
  props: {
    department: Object,
    hover: Boolean,
  },
  methods: {
    getCardClass(department) {
      // Implement your logic to assign a dynamic class to each card based on department properties
    },
    getIconColor(department) {
      // Implement your logic to assign a color to the icon based on department properties
    },
    getRandomIcon() {
      const icons = ["mdi-icon-1", "mdi-icon-2", "mdi-icon-3"]; // Replace with your icon list
      const randomIndex = Math.floor(Math.random() * icons.length);
      return icons[randomIndex];
    },
    openDetailDialog(department) {
      this.$emit("open-detail-dialog", department);
    },
    openEditDialog(department) {
      this.$emit("open-edit-dialog", department);
    },
    deleteDepartment(id) {
      this.$emit("delete-department", id);
    },
  },
};
</script>
