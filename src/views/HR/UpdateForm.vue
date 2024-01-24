<template>
  <v-container>
    <v-form ref="form" v-model="valid">
      <v-row>
        <!-- Text Fields -->
        <v-col cols="12" md="6">
          <v-text-field label="Name" prepend-icon="mdi-account" required v-model="formData.name"></v-text-field>
        </v-col>
        <!-- <v-col cols="12" md="6">
          <v-text-field label="UserID" prepend-icon="mdi-account-circle" required v-model="formData.userID"></v-text-field>
        </v-col> -->
        <!-- <v-col cols="12" md="6">
          <v-text-field label="EID" prepend-icon="mdi-badge-account-horizontal" required v-model="formData.EID"></v-text-field>
        </v-col> -->
        <!-- <v-col cols="12" md="6">
          <v-text-field label="SupervisorID" prepend-icon="mdi-account-supervisor" required v-model="formData.supervisorID"></v-text-field>
        </v-col> -->
        <v-col cols="12" md="6">
          <v-text-field label="Email" prepend-icon="mdi-email" required type="email" v-model="formData.email"></v-text-field>
        </v-col>
        <v-col cols="12" md="6">
          <v-text-field label="Phone Number" prepend-icon="mdi-phone" type="tel" v-model="formData.phoneNumber"></v-text-field>
        </v-col>
        <v-col cols="12" md="6">
  <v-select
    label="Gender"
    prepend-icon="mdi-gender-male-female"
    :items="['Male', 'Female']"
    v-model="formData.gender"
    required
  ></v-select>
</v-col>

        <v-col cols="12" md="6">
          <v-text-field label="Passport/National ID Number" prepend-icon="mdi-passport" v-model="formData.passportOrNationalIDNumber"></v-text-field>
        </v-col>
        <v-col cols="12" md="6">
          <v-text-field label="Address" prepend-icon="mdi-home" v-model="formData.address"></v-text-field>
        </v-col>
        <v-col cols="12" md="6">
          <v-text-field label="City" prepend-icon="mdi-city" v-model="formData.city"></v-text-field>
        </v-col>
        <v-col cols="12" md="6">
  <v-autocomplete
    label="Country"
    prepend-icon="mdi-earth"
    :items="countries"
    v-model="formData.country"
    :filter="customFilter"
    clearable
  ></v-autocomplete>
</v-col>
<v-col cols="12" md="6">
  <v-select
    label="Employee Type"
    prepend-icon="mdi-briefcase"
    :items="['International', 'Local']"
    v-model="formData.employeeType"
    required
  ></v-select>
</v-col>
        <!-- <v-col cols="12" md="6">
          <v-text-field label="PID" prepend-icon="mdi-identifier" required v-model="formData.PID"></v-text-field>
        </v-col> -->
        <v-col cols="12" md="6">
          <v-text-field label="Bank Account Number" prepend-icon="mdi-bank" required v-model="formData.bankAccountNumber"></v-text-field>
        </v-col>
        <v-col cols="12" md="6">
          <v-text-field label="Bank Account Name" prepend-icon="mdi-account" required v-model="formData.bankAccountName"></v-text-field>
        </v-col>
        <v-col cols="12" md="6">
          <v-text-field label="Bank Name" prepend-icon="mdi-bank" required v-model="formData.bankName"></v-text-field>
        </v-col>
        <v-col cols="12" md="6">
          <v-text-field label="Salary Per Month (USD)" prepend-icon="mdi-cash" required v-model="formData.salaryPerMonthInUsd"></v-text-field>
        </v-col>
        <v-col cols="12" md="6">
          <v-text-field label="Taxable Salary Amount (USD)" prepend-icon="mdi-cash-plus" required v-model="formData.taxableSalaryAmountInUsd"></v-text-field>
        </v-col>
        <!-- <v-col cols="12" md="6">
          <v-text-field label="Contract Validity (Months)" prepend-icon="mdi-timer-sand" required type="number" v-model="formData.contractValidityInMonths"></v-text-field>
        </v-col> -->
        <!-- <v-col cols="12" md="6">
          <v-text-field label="DID" prepend-icon="mdi-identifier" v-model="formData.DID"></v-text-field>
        </v-col> -->

        <!-- Date Pickers -->
        <v-col cols="12" md="6">
          <v-menu ref="menuDateOfBirth" v-model="menuDateOfBirth" :close-on-content-click="false" :nudge-right="40" :return-value.sync="formData.dateOfBirth" transition="scale-transition" offset-y min-width="auto">
            <template v-slot:activator="{ on, attrs }">
              <v-text-field v-bind="attrs" v-on="on" label="Date of Birth" prepend-icon="mdi-calendar" readonly v-model="formData.dateOfBirth"></v-text-field>
            </template>
            <v-date-picker v-model="formData.dateOfBirth" @input="menuDateOfBirth = false"></v-date-picker>
          </v-menu>
        </v-col>
        <v-col cols="12" md="6">
          <v-menu ref="menuDateOfJoining" v-model="menuDateOfJoining" :close-on-content-click="false" :nudge-right="40" :return-value.sync="formData.dateOfJoining" transition="scale-transition" offset-y min-width="auto">
            <template v-slot:activator="{ on, attrs }">
              <v-text-field v-bind="attrs" v-on="on" label="Date of Joining" prepend-icon="mdi-calendar-check" readonly v-model="formData.dateOfJoining"></v-text-field>
            </template>
            <v-date-picker v-model="formData.dateOfJoining" @input="menuDateOfJoining = false"></v-date-picker>
          </v-menu>
        </v-col>
      </v-row>
      <v-btn color="primary" :disabled="!valid" @click="submitForm">Submit</v-btn>
    </v-form>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      valid: true,
      menuDateOfBirth: false,
      menuDateOfJoining: false,
      // valid: true,
      countries: [], // Array to hold countries
      formData: {
        name: '',
        userID: '',
        EID: '',
        supervisorID: '',
        email: '',
        phoneNumber: '',
        dateOfBirth: new Date().toISOString().substr(0, 10),
        gender: '',
        passportOrNationalIDNumber: '',
        address: '',
        city: '',
        country: '',
        employeeType: '',
        PID: '',
        bankAccountNumber: '',
        bankAccountName: '',
        bankName: '',
        salaryPerMonthInUsd: '',
        taxableSalaryAmountInUsd: '',
        dateOfJoining: new Date().toISOString().substr(0, 10),
        contractValidityInMonths: '',
        DID: ''
      }
    };
  },
  methods: {
    submitForm() {
      if (this.$refs.form.validate()) {
        console.log('Form Data:', this.formData);
        // Add your submission logic here, e.g., making an API call
      }
    },
    customFilter(item, queryText, itemText) {
      const textOne = item.toLowerCase();
      const searchText = queryText.toLowerCase();

      return textOne.indexOf(searchText) > -1;
    }
  },
  mounted() {
    fetch('https://restcountries.com/v2/all')
      .then(response => response.json())
      .then(data => {
        this.countries = data.map(country => country.name);
      })
      .catch(error => {
        console.error('Error fetching countries:', error);
        this.countries = ['Error loading countries'];
      });
  },
};


</script>

<style>
/* Add any custom styles here */
</style>
