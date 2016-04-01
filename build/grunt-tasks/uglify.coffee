thirdPartyFiles = [
  'dist/client/bower_components/jquery/dist/jquery.js'
  'dist/client/bower_components/md5/index.js'
  'dist/client/bower_components/timeago/jquery.timeago.js'
  'dist/client/bower_components/eventEmitter/EventEmitter.js'
  'dist/client/bower_components/handlebars/handlebars.runtime.js'
  'dist/client/bower_components/pagejs/page.js'
]

appFiles = [
  'dist/client/js/templates.js'
  'dist/client/js/EventEmitter.js'
  'dist/client/js/Router.js'

  'dist/client/js/views/BaseView.js'
  'dist/client/js/views/**/*.js'

  'dist/client/js/AppView.js'
  'dist/client/js/AppController.js'
]


module.exports = (grunt) ->

  config                =
    third_party         :
      options           :
        mangle          : yes
      files             : 'dist/client/js/compose.third_party.min.js': thirdPartyFiles
    prod                :
      files             : 'dist/client/js/compose.min.js': appFiles
      options           :
        screwIE8        : yes
        compress        :
          dead_code     : yes
          drop_debugger : yes
          warnings      : yes
          drop_console  : yes
          sequences     : no
    dev                 :
      files             : 'dist/client/js/compose.js': appFiles
      options           :
        beautify        : yes
        mangle          : no
        compress        :
          drop_debugger : no
          drop_console  : no
          sequences     : no


  grunt.config 'uglify', config
