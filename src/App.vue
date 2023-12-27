<template>
  <v-app>
    <NavBar />
    <Sidebar />
    <v-main>
      <router-view></router-view>
    </v-main>
  </v-app>
</template>

<script>
import NavBar from './components/General/NavBar.vue';
import Sidebar from './components/General/SideBar.vue';

export default {
  components: {
    NavBar,
    Sidebar
  },
};
</script>

<style>
  /* Global styles */
</style>
