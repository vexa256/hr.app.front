import axios from "axios";
import Swal from "sweetalert2";

// Define the fetchClusters function with parameters
export function GlobalDataFetcher(tableName, excludeColumns, callback) {
  axios
    .post(window.SERVER_URL + "GlobalDataFetcher", {
      TableName: tableName,
      ExcludeColumns: excludeColumns,
    })
    .then((response) => {
      // Call the callback function with the fetched data
      callback(response.data.data);
    })
    .catch((error) => {
      console.error("Error fetching clusters:", error);
      Swal.fire("Error", "Failed to fetch clusters", "error");
    });
}


export function GlobalDelete(tableName, clusterId, callback) {
  axios
    .post(window.SERVER_URL + "MassDelete", {
      TableName: tableName,
      id: clusterId,
    })
    .then(() => {
      Swal.fire("Deleted!", "The cluster has been deleted.", "success");
      if (callback) {
        callback();
      }
    })
    .catch((error) => {
      console.error("Error deleting cluster:", error);
      Swal.fire("Error", "Failed to delete cluster", "error");
    });
}


// Global function for inserting data into a cluster
export function GlobalDataInserter(formId, successCallback, errorCallback) {
  const form = document.getElementById(formId);
  if (!form) {
    errorCallback("Form not found.");
    return;
  }

  const formData = new FormData(form);
  const apiUrl = window.SERVER_URL + "MassInsert";

  // Validation for empty fields
  let emptyFields = [];
  for (let [key, value] of formData.entries()) {
    if (value.trim() === "") {
      emptyFields.push(key);
    }
  }

  if (emptyFields.length > 0) {
    Swal.fire({
      title: "Missing Information",
      text: "Please fill in all the fields. Missing: " + emptyFields.join(", "),
      icon: "warning",
      confirmButtonText: "Ok",
    });
    return; // Stop the function here
  }

  axios
    .post(apiUrl, formData)
    .then((response) => {
      if (response.status === 200) {
        successCallback(response.data);
      } else {
        errorCallback(response.data);
      }
    })
    .catch((error) => {
      errorCallback(error);
    });
}


// Global function for updating a cluster
export function GlobalUpdater(formId, successCallback, errorCallback) {
  const form = document.getElementById(formId);
  if (!form) {
    errorCallback("Form not found.");
    return;
  }

  const formData = new FormData(form);
  const apiUrl = window.SERVER_URL + "MassUpdate";

  // Validation for empty fields
  let emptyFields = [];
  for (let [key, value] of formData.entries()) {
    if (value.trim() === "") {
      emptyFields.push(key);
    }
  }

  if (emptyFields.length > 0) {
    Swal.fire({
      title: "Missing Information",
      text: "Please fill in all the fields. Missing: " + emptyFields.join(", "),
      icon: "warning",
      confirmButtonText: "Ok",
    });
    return; // Stop the function here
  }

  axios
    .post(apiUrl, formData)
    .then((response) => {
      if (response.status === 200) {

        console.log(response.status);

        successCallback(response.data);

      } else {

        errorCallback(response.data);

        console.log(response);

      }
    })
    .catch((error) => {
      errorCallback(error);

      console.log(error);

    });
}
