module.exports = (grunt) ->

  options        =
    options      :
      livereload : yes
      interrupt  : yes
    configFiles  :
      files      : [ 'Gruntfile.coffee' ]
      options    :
        reload   : yes
    phtml        :
      files      : [ 'client/**/*.html' ]
      tasks      : [ 'copy:pages', ]
    coffee       :
      files      : [ '**/*.coffee' ]
      tasks      : [ 'coffee', 'uglify:dev', ]
    stylus       :
      files      : [ '**/*.styl' ]
      tasks      : [ 'stylus', 'uglify:dev', ]
    templates    :
      files      : [ '**/*.hbs' ]
      tasks      : [ 'handlebars', 'uglify:dev', ]

  grunt.config 'watch', options
