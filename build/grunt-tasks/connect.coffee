modRewrite = require 'connect-modrewrite'


module.exports = (grunt) ->

  options     =
    dev       :
      options :
        base  : 'dist/client'
        host  : '127.0.0.1'
        port  : 1111
        open  : yes

  grunt.config 'connect', options
