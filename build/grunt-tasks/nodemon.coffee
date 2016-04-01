module.exports = (grunt) ->

  config     =
    dev      :
      script : 'dist/server/index.js'

  grunt.config 'nodemon', config
