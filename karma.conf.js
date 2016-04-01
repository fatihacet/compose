module.exports = function(config) {
  config.set({
    basePath: '',
    frameworks: [ 'jasmine' ],
    files: [
      'dist/client/js/compose.third_party.min.js',
      'dist/client/js/compose.js',
      'dist/client/js/tests/**/*.js',
    ],
    exclude: [
    ],
    preprocessors: {},
    reporters: [ 'dots' ],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    browsers: [ 'PhantomJS' ]
  });
};
