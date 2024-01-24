<template>
  <v-container>
    <v-form ref="form" v-model="valid">
      <v-row>
        <v-col cols="12" md="6" v-for="field in fields" :key="field.name">
          <v-text-field
            v-if="field.type !== 'date'"
            :label="field.label"
            :type="field.type"
            :rules="field.rules"
            required
            v-model="formData[field.name]"
            :prepend-icon="field.icon"
          ></v-text-field>
          <v-date-picker
            v-else
            :label="field.label"
            :rules="field.rules"
            required
            v-model="formData[field.name]"
            :prepend-icon="field.icon"
          ></v-date-picker>
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
      valid: false,
      formData: {
        name: '',
        userID: '',
        EID: '',
        supervisorID: '',
        email: '',
        phoneNumber: '',
        dateOfBirth: new Date().toISOString().substr(0, 10), // Initialize with a valid date string
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
        dateOfJoining: new Date().toISOString().substr(0, 10), // Initialize with a valid date string
        contractValidityInMonths: '',
        DID: ''
      },
      fields: [
        { name: 'name', label: 'Name', type: 'text', icon: 'mdi-account', rules: [v => !!v || 'Name is required'] },
        { name: 'userID', label: 'UserID', type: 'text', icon: 'mdi-account-circle', rules: [v => !!v || 'UserID is required'] },
        { name: 'EID', label: 'EID', type: 'text', icon: 'mdi-badge-account-horizontal', rules: [v => !!v || 'EID is required'] },
        { name: 'supervisorID', label: 'Supervisor ID', type: 'text', icon: 'mdi-account-supervisor', rules: [v => !!v || 'Supervisor ID is required'] },
        { name: 'email', label: 'Email', type: 'email', icon: 'mdi-email', rules: [v => !!v || 'Email is required', v => /.+@.+\..+/.test(v) || 'Email must be valid'] },
        { name: 'phoneNumber', label: 'Phone Number', type: 'tel', icon: 'mdi-phone', rules: [v => !!v || 'Phone Number is required'] },
        { name: 'dateOfBirth', label: 'Date of Birth', type: 'date', icon: 'mdi-calendar', rules: [v => !!v || 'Date of Birth is required'] },
        { name: 'gender', label: 'Gender', type: 'text', icon: 'mdi-gender-male-female', rules: [v => !!v || 'Gender is required'] },
        { name: 'passportOrNationalIDNumber', label: 'Passport/National ID', type: 'text', icon: 'mdi-passport', rules: [v => !!v || 'Passport/National ID is required'] },
        { name: 'address', label: 'Address', type: 'text', icon: 'mdi-home', rules: [v => !!v || 'Address is required'] },
        { name: 'city', label: 'City', type: 'text', icon: 'mdi-city', rules: [v => !!v || 'City is required'] },
        { name: 'country', label: 'Country', type: 'text', icon: 'mdi-earth', rules: [v => !!v || 'Country is required'] },
        { name: 'employeeType', label: 'Employee Type', type: 'text', icon: 'mdi-briefcase', rules: [v => !!v || 'Employee Type is required'] },
        { name: 'PID', label: 'PID', type: 'text', icon: 'mdi-identifier', rules: [v => !!v || 'PID is required'] },
        { name: 'bankAccountNumber', label: 'Bank Account Number', type: 'text', icon: 'mdi-bank', rules: [v => !!v || 'Bank Account Number is required'] },
        { name: 'bankAccountName', label: 'Bank Account Name', type: 'text', icon: 'mdi-account', rules: [v => !!v || 'Bank Account Name is required'] },
        { name: 'bankName', label: 'Bank Name', type: 'text', icon: 'mdi-bank', rules: [v => !!v || 'Bank Name is required'] },
        { name: 'salaryPerMonthInUsd', label: 'Salary (USD/Month)', type: 'text', icon: 'mdi-cash', rules: [v => !!v || 'Salary is required'] },
        { name: 'taxableSalaryAmountInUsd', label: 'Taxable Salary (USD)', type: 'text', icon: 'mdi-cash-plus', rules: [v => !!v || 'Taxable Salary is required'] },
        { name: 'dateOfJoining', label: 'Date of Joining', type: 'date', icon: 'mdi-calendar-check', rules: [v => !!v || 'Date of Joining is required'] },
        { name: 'contractValidityInMonths', label: 'Contract Validity (Months)', type: 'number', icon: 'mdi-timer-sand', rules: [v => !!v || 'Contract Validity is required'] },
        { name: 'DID', label: 'DID', type: 'text', icon: 'mdi-identifier', rules: [] }
      ]
    };
  },
  methods: {
    submitForm() {
      if (this.$refs.form.validate()) {
        // Placeholder for form submission logic
        alert('Form submitted!');
        console.log('Form Data:', this.formData);
        // Implement your API call or form submission logic here
      }
    }
  }
};
</script>

<style>
/* Add any custom styles you need here */
</style>
