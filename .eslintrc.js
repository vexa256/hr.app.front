module.exports = {
  root: true,
  env: {
    node: true,
  },
  extends: [
    'plugin:vue/vue3-essential',
    'eslint:recommended',
    '@vue/typescript/recommended' // If using TypeScript
  ],
  rules: {
    'no-unused-vars': 'off',
    '@typescript-eslint/no-unused-vars': 'off', // Disable for TypeScript
    'vue/valid-v-slot': ['error', {
      allowModifiers: true, // Allow modifiers in v-slot
    }],
  }
}
