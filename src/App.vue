<template>
  <v-app>
    <NavBar />
    <Sidebar />
    <v-main>
      <router-view></router-view>
    </v-main>
    <!-- Overlay Loader -->
    <div v-if="isLoading" class="overlay">
      <div class="loader">
        <div class="cube1"></div>
        <div class="cube2"></div>
        <div class="cube3"></div>
      </div>
      <p class="loading-text">Please wait...</p>
    </div>
  </v-app>
</template>

<script>
import axios from "axios";
import NavBar from "./components/General/NavBar.vue";
import Sidebar from "./components/General/SideBar.vue";

export default {
  components: {
    NavBar,
    Sidebar,
  },
  data() {
    return {
      isLoading: false,
      requestCounter: 0,
    };
  },
  methods: {
    increaseLoader() {
      this.requestCounter++;
      this.isLoading = true;
    },
    decreaseLoader() {
      if (this.requestCounter > 0) this.requestCounter--;
      if (this.requestCounter === 0) this.isLoading = false;
    },
  },
  created() {
    // Set up Axios Interceptors
    axios.interceptors.request.use(
      (config) => {
        this.increaseLoader();
        return config;
      },
      (error) => {
        this.decreaseLoader();
        return Promise.reject(error);
      }
    );

    axios.interceptors.response.use(
      (response) => {
        this.decreaseLoader();
        return response;
      },
      (error) => {
        this.decreaseLoader();
        return Promise.reject(error);
      }
    );
  },
};
</script>

<style>
/* Global styles */
.overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: rgba(0, 0, 0, 0.7);
  z-index: 10000;
}

.loader {
  position: relative;
  width: 100px;
  height: 100px;
}

.loader div {
  background-color: #3498db;
  width: 30px;
  height: 30px;
  position: absolute;
  animation: cubeMovement 1.8s infinite ease-in-out;
}

.cube1 {
  top: 0;
  left: 0;
}

.cube2 {
  top: 0;
  right: 0;
  animation-delay: -0.9s;
}

.cube3 {
  bottom: 0;
  left: 0;
  animation-delay: -0.45s;
}

@keyframes cubeMovement {
  0%,
  70%,
  100% {
    transform: scale(1);
  }
  35% {
    transform: scale(0);
  }
}

.loading-text {
  margin-top: 20px;
  color: white;
  font-size: 1.5em;
  text-align: center;
}
</style>
