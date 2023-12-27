// axios-setup.js
import axios from 'axios';

window.SERVER_URL = "http://172.24.84.93:8000/api/";

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
  // Check if the error comes from Laravel and handle it
  if (error.response && error.response.data && error.response.data.errors) {
    console.error('Laravel errors:', error.response.data.errors);
  }
  return Promise.reject(error);
});
