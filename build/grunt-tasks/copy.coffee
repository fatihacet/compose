module.exports = (grunt) ->

  options        =
    root         :
      expand     : yes
      dest       : 'dist/client'
      cwd        : '.'
      src        : [ 'bower_components/**', 'favicon.ico' ]

    pages        :
      expand     : yes
      cwd        : 'client'
      src        : [ '*.html', 'images/*' ]
      dest       : 'dist/client'

  grunt.config 'copy', options
