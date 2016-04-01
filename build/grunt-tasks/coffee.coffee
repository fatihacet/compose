module.exports = (grunt) ->

  options       =
    client      :
      options   :
        bare    : yes
      files     : [
        expand  : yes
        cwd     : 'client/src'
        src     : '**/*.coffee'
        dest    : 'dist/client/js'
        ext     : '.js'
      ]
    server      :
      options   :
        bare    : yes
      files     : [
        expand  : yes
        cwd     : 'server'
        src     : '**/*.coffee'
        dest    : 'dist/server'
        ext     : '.js'
      ]

  grunt.config 'coffee', options
