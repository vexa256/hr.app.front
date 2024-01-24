<template>
  <div>
    <v-autocomplete
      label="Nationality"
      :items="[
        'Algeria',
        'Angola',
        'Benin',
        'Botswana',
        'Burkina Faso',
        'Burundi',
        'Cabo Verde',
        'Cameroon',
        'Central African Republic',
        'Chad',
        'Comoros',
        'Congo (Brazzaville)',
        'Congo (Kinshasa)',
        'Cote d\'Ivoire',
        'Djibouti',
        'Egypt',
        'Equatorial Guinea',
        'Eritrea',
        'Eswatini',
        'Ethiopia',
        'Gabon',
        'Gambia',
        'Ghana',
        'Guinea',
        'Guinea-Bissau',
        'Kenya',
        'Lesotho',
        'Liberia',
        'Libya',
        'Madagascar',
        'Malawi',
        'Mali',
        'Mauritania',
        'Mauritius',
        'Morocco',
        'Mozambique',
        'Namibia',
        'Niger',
        'Nigeria',
        'Rwanda',
        'Sao Tome and Principe',
        'Senegal',
        'Seychelles',
        'Sierra Leone',
        'Somalia',
        'South Africa',
        'South Sudan',
        'Sudan',
        'Tanzania',
        'Togo',
        'Tunisia',
        'Uganda',
        'Zambia',
        'Zimbabwe',
      ]"
      v-model="selectedNationality"
      prepend-icon="mdi-earth"
    ></v-autocomplete>

    <!-- Hidden field -->
    <input type="hidden" name="Nationality" :value="selectedNationality" />
  </div>
</template>

<script>
export default {
  data() {
    return {
      selectedNationality: "",
    };
  },
};
</script>
