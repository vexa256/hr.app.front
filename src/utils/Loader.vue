<template>
  <v-container
    class="loader-container"
    fluid
    style="height: 100%; overflow: hidden"
  >
    <v-row justify="center" align="center">
      <v-col cols="12" class="text-center">
        <!-- Custom 3D Loader -->
        <!-- <div class="custom-3d-loader"></div> -->

        <!-- Loader Text -->
        <div class="loader-text">{{ currentMessage }}</div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: "LoaderComponent",
  data() {
    return {
      loadingMessages: [
        "Please wait, we're getting things ready...",
        "Working on your request, just a moment...",
        "Hang tight, we're on it...",
        "Just a bit longer, thank you for your patience...",
        "Processing your request...",
        "Almost there...",
        "Your request is important to us, please hold on...",
        "Gathering the bits and bytes...",
        "We appreciate your patience...",
        "Loading, please stand by...",
        "Finalizing details...",
        "Preparing your experience...",
      ],
      currentMessage: "Loading...",
    };
  },
  mounted() {
    this.changeLoadingText();
    this.interval = setInterval(this.changeLoadingText, 2000);

    // Navigate back after 500ms
    setTimeout(() => {
      this.$router.back();
    }, 500);
  },
  beforeDestroy() {
    clearInterval(this.interval);
  },
  methods: {
    changeLoadingText() {
      const randomIndex = Math.floor(
        Math.random() * this.loadingMessages.length
      );
      this.currentMessage = this.loadingMessages[randomIndex];
    },
  },
};
</script>

<style scoped>
.loader-container {
  height: 100vh;
  background-color: #1976d2;
  perspective: 1200px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.custom-3d-loader {
  width: 200px;
  height: 200px;
  position: relative;
  animation: rotateLoader 5s linear infinite;
}

.custom-3d-loader::before,
.custom-3d-loader::after {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  border-radius: 50%;
  background: linear-gradient(
    45deg,
    rgba(255, 255, 255, 0.1),
    rgba(255, 255, 255, 0.2)
  );
  animation: rotateLayer 4s linear infinite;
}

.custom-3d-loader::after {
  animation-delay: -2s;
}

@keyframes rotateLoader {
  0% {
    transform: rotateX(0deg) rotateY(0deg) rotateZ(0deg);
  }
  100% {
    transform: rotateX(360deg) rotateY(360deg) rotateZ(360deg);
  }
}

@keyframes rotateLayer {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

.loader-text {
  margin-top: 20px;
  font-size: 32px;
  font-weight: bold;
  color: white;
}
</style>
