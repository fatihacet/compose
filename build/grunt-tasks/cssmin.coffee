module.exports = (grunt) ->

  config      =
    options   :
      shorthandCompacting : no
      roundingPrecision   : -1
      keepSpecialComments : 0
    target    :
      files   :
        'dist/client/css/compose.min.css': [
          'dist/client/css/reset.css'
          'dist/client/css/layout.css'
          'dist/client/css/landing.css'
          'dist/client/css/sidebar.css'
          'dist/client/css/mail-list.css'
          'dist/client/css/mail-content.css'
          'dist/client/css/compose.css'
        ]

  grunt.config 'cssmin', config
