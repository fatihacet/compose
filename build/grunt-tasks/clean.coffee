module.exports = (grunt) ->

  options     =
    all       :
      options : force: yes
      src     : 'dist'
    css       :
      options : force: yes
      src     : 'dist/client/css'
    js        :
      options : force: yes
      src     : 'dist/client/js'

  grunt.config 'clean', options
