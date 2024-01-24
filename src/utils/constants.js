import axios from 'axios';

window.SERVER_URL = "http://localhost:8000/api/";

import Swal from 'sweetalert2';



window.GlobalDataUpdateLogic = async (formId) => {
  const form = document.getElementById(formId);
  if (!form) {
      Swal.fire("Update form error", 'Form not found', "error");
      return;
  }

  try {
      const formData = new FormData(form);
      const response = await axios.post(window.SERVER_URL + "MassUpdate", formData);

      // Handle server response
      if (response.data.errors) {
          Swal.fire({
              title: 'Error!',
              text: 'There were errors in your submission',
              icon: 'error',
              confirmButtonText: 'OK'
          });
      } else {
          Swal.fire({
              title: 'Success!',
              text: response.data.status,
              icon: 'success',
              confirmButtonText: 'OK'
          });
      }
  } catch (error) {
      Swal.fire({
          title: 'Error!',
          text: error.message,
          icon: 'error',
          confirmButtonText: 'OK'
      });
  }
};
// Request interceptor
axios.interceptors.request.use(request => {
  console.log('Starting Request', request);
  // You can modify the request here
  return request;
}, error => {
  console.error('Request error:', error);
  return Promise.reject(error);
});

// Response interceptor
axios.interceptors.response.use(response => {
  console.log('Response:', response);
  return response;
}, error => {
  console.error('Response error:', error);
  if (error.response && error.response.data && error.response.data.errors) {
    console.error('Laravel errors:', error.response.data.errors);
  }
  return Promise.reject(error);
});

window.icons = [
  "mdi-account",
  "mdi-bank",
  "mdi-chart-bar",
  "mdi-checkbox-marked",
  "mdi-check-circle",
  "mdi-clock",
  "mdi-calendar",
  "mdi-email",
  "mdi-file-document",
  "mdi-folder",
  "mdi-globe-model",
  "mdi-laptop",
  "mdi-lightbulb",
  "mdi-lock",
  "mdi-map-marker",
  "mdi-message-text",
  "mdi-phone",
  "mdi-printer",
  "mdi-security",
  "mdi-table",
  "mdi-television",
  "mdi-thermometer",
  "mdi-timer-sand",
  "mdi-trophy",
  "mdi-wallet",
  "mdi-web",
  "mdi-worker",
  "mdi-wrench",
  "mdi-briefcase",
  "mdi-bullhorn",
  "mdi-cellphone",
  "mdi-chair-rolling",
  "mdi-chart-pie",
  "mdi-city",
  "mdi-clipboard-text",
  "mdi-clock-fast",
  "mdi-credit-card",
  "mdi-desktop-classic",
  "mdi-domain",
  "mdi-factory",
  "mdi-file-chart",
  "mdi-finance",
  "mdi-flask",
  "mdi-flower",
  "mdi-folder-network",
  "mdi-gavel",
  "mdi-glasses",
  "mdi-hammer",
  "mdi-lamp",
  "mdi-magnet",
  "mdi-account",
  "mdi-bank",
  "mdi-chart-bar",
  "mdi-checkbox-marked",
  "mdi-check-circle",
  "mdi-clock",
  "mdi-calendar",
  "mdi-email",
  "mdi-file-document",
  "mdi-folder",
  "mdi-globe-model",
  "mdi-laptop",
  "mdi-lightbulb",
  "mdi-lock",
  "mdi-map-marker",
  "mdi-message-text",
  "mdi-phone",
  "mdi-printer",
  "mdi-security",
  "mdi-table",
  "mdi-television",
  "mdi-thermometer",
  "mdi-timer-sand",
  "mdi-trophy",
  "mdi-wallet",
  "mdi-web",
  "mdi-worker",
  "mdi-wrench",
  "mdi-briefcase",
  "mdi-bullhorn",
  "mdi-cellphone",
  "mdi-chair-rolling",
  "mdi-chart-pie",
  "mdi-city",
  "mdi-clipboard-text",
  "mdi-clock-fast",
  "mdi-credit-card",
  "mdi-desktop-classic",
  "mdi-domain",
  "mdi-factory",
  "mdi-file-chart",
  "mdi-finance",
  "mdi-flask",
  "mdi-flower",
  "mdi-folder-network",
  "mdi-gavel",
  "mdi-glasses",
  "mdi-hammer",
  "mdi-lamp",
  "mdi-magnet",
  "mdi-microscope",
  "mdi-monitor",
  "mdi-notebook",
  "mdi-nut",
  "mdi-paperclip",
  "mdi-pencil",
  "mdi-puzzle",
  "mdi-ruler",
  "mdi-saw-blade",
  "mdi-school",
  "mdi-scissors-cutting",
  "mdi-screwdriver",
  "mdi-server",
  "mdi-settings",
  "mdi-shape",
  "mdi-sitemap",
  "mdi-stairs",
  "mdi-stethoscope",
  "mdi-store",
  "mdi-suitcase",
  "mdi-tag",
  "mdi-ticket",
  "mdi-tools",
  "mdi-train",
  "mdi-trending-up",
  "mdi-umbrella",
  "mdi-usb",
  "mdi-van-passenger",
  "mdi-van-utility",
  "mdi-wifi",
  "mdi-zip-box"
];

