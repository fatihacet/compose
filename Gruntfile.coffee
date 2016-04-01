taskLoader = require 'load-grunt-tasks'
targets    = require './build/grunt-tasks/targets.coffee'

module.exports = (grunt) ->

  grunt.loadTasks 'build/grunt-tasks'
  taskLoader grunt

  { defaults, client, server, build } = targets()

  grunt.registerTask 'default', defaults.desc, ->
    grunt.task.run defaults.tasks

  grunt.registerTask 'client', client.desc, ->
    grunt.task.run client.tasks

  grunt.registerTask 'server', server.desc, ->
    grunt.task.run server.tasks

  grunt.registerTask 'build', build.desc, ->
    grunt.task.run build.tasks
