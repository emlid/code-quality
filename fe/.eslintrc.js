module.exports = {
  root: true,
  env: {
    node: true
  },
  extends: ['plugin:vue/essential', '@vue/typescript', 'airbnb-base'],
  rules: {
    // Enforce line breaks between array elements
    'array-element-newline': ['error', { 'multiline': true, 'minItems': 3 }],

    // Do not enforce class method to utilize `this`
    'class-methods-use-this': 'off',

    // Require trailing commas for multiline statements
    'comma-dangle': ['error', {
      arrays: 'only-multiline',
      objects: 'only-multiline',
      imports: 'never',
      exports: 'never',
      functions: 'never',
    }],

    // Do not enforce `require` to be called only in the top level of a module
    'global-require': 'off',

    // Ignore `import` statements with Webpack `@` alias in path
    'import/no-unresolved': ['error', { ignore: ['^@'] }],

    // Do not permit `console` references or `debugger` statements in production bundle
    'no-console': process.env.NODE_ENV === 'production' ? 'error' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off',

    // Base indent of 2 spaces in `.vue` files
    'vue/script-indent': ['error', 2, { 'baseIndent': 1 }]
  },
  'overrides': [
    {
      // Disable default ESLint indentation rule for `.vue` files `<script>` section
      'files': ['*.vue'],
      'rules': {
        'indent': 'off'
      }
    }
  ],
  parserOptions: {
    parser: '@typescript-eslint/parser'
  }
};
