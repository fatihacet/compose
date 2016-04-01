module.exports = (grunt) ->

  options        =
    tests        :
      configFile : 'karma.conf.js'

  grunt.config 'karma', options
