module.exports = (grunt) ->

  options        =
    options      : 'include css': yes
    all          :
      files      : [
        compress : no
        expand   : yes
        cwd      : 'client/styl'
        src      : [ '**/*.styl' ]
        dest     : 'dist/client/css/'
        ext      : '.css'
      ]

  grunt.config 'stylus', options
