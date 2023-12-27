<template>
  <v-container>
    <v-card class="mx-auto" max-width="800">
      <v-card-title class="headline">User Profile</v-card-title>
      <v-list three-line>
        <v-list-item>
          <v-list-item-avatar>
            <v-img :src="user.avatar"></v-img>
          </v-list-item-avatar>
          <v-list-item-content>
            <v-list-item-title>{{ user.name }}</v-list-item-title>
            <v-list-item-subtitle>{{ user.email }}</v-list-item-subtitle>
          </v-list-item-content>
          <v-list-item-icon>
            <v-icon>mdi-account-circle</v-icon>
          </v-list-item-icon>
        </v-list-item>
        <!-- Additional user details here -->
      </v-list>
      <v-card-actions>
        <v-btn color="primary" @click="editProfile">Edit Profile</v-btn>
      </v-card-actions>
    </v-card>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      // Example user data, should be fetched from backend
      user: {
        name: 'John Doe',
        email: 'johndoe@example.com',
        avatar: 'https://example.com/avatar.jpg',
      },
    };
  },
  methods: {
    editProfile() {
      // Logic to edit user profile
    },
  },
};
</script>

<style>
  /* Additional styling can be added here */
</style>
