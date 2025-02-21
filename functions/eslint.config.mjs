// eslint.config.mjs
import globals from 'globals'; //Import the globals package

export default [
  {
    languageOptions: {
      ecmaVersion: 'latest',
      sourceType: 'module',
      globals: {
        ...globals.browser, //If you are using browser code
        ...globals.node, //If you are using node code
        ...globals.es2021 //If you are using es2021 code
      }
    },
    rules: {
      'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
      'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    }
  }
];