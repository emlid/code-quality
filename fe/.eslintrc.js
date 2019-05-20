module.exports = {
  root: true,
  env: { browser: true, node: true },
  extends: [
    'plugin:vue/essential',
    '@vue/typescript',
    'airbnb-base'
  ],
  rules: {
    // Enforce line breaks between array elements
    'array-element-newline': ['error', { 'multiline': true, 'minItems': 3 }],

    // Omit parentheses when arrow function have exactly one parameter
    'arrow-parens': 'off',

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

    // Set maximum line length to 120 characters. Lines containing URLs, strings, template literals or regular
    // expressions will be ignored.
    'max-len': ['error', {
      'code': 120,
      'ignoreUrls': true,
      'ignoreStrings': true,
      'ignoreTemplateLiterals': true,
      'ignoreRegExpLiterals': true
    }],

    // Do not permit `console` references or `debugger` statements in production bundle
    'no-console': process.env.NODE_ENV === 'production' ? 'error' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off',

    // Requires the use of single quotes wherever possible. Double quotes are allowed as long as the string contains
    // a single quote that would have to be escaped otherwise.
    'quotes': [
      'error',
      'single',
      { 'avoidEscape': true }
    ],

    // Sorts all imports alphabetically, case-sensitively, without declaration sort
    'sort-imports': 'error',

    // Limit the maximum number of attributes/properties per line
    'vue/max-attributes-per-line': ['error', {
      'singleline': 1,
      'multiline': {
        'max': 1,
        'allowFirstLine': false
      }
    }],

    // Base indent of 2 spaces in `.vue` files
    'vue/script-indent': [
      'error',
      2,
      { 'baseIndent': 1 },
    ]
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
