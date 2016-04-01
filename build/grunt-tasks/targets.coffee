commonTasks = [ 'clean', 'includes', 'copy', 'stylus', 'cssmin', 'handlebars', 'coffee', 'uglify' ]
devTasks    = [ 'connect', 'watch' ]
buildTasks  = [ 'preprocess:prod' ]
serverTasks = [ 'nodemon:dev' ]
deployTasks = [ 'git_deploy' ]

commonTasks.splice 1, 1 # remove mkdir for now

module.exports = ->

  defaults :
    desc   : 'Development target'
    tasks  : commonTasks.concat devTasks

  client   :
    desc   : 'Development target for client'
    tasks  : commonTasks.concat devTasks

  server   :
    desc   : 'Development target for server'
    tasks  : serverTasks

  build    :
    desc   : 'Generate files'
    tasks  : commonTasks.concat buildTasks
