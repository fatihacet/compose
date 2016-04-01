path    = require 'path'
compose = require './compose'


module.exports =

  ###*
    Express routes for both server and client.
  ###
  init: (app, router) ->

    router
      .route '/api/mail/:action?'
        .get  (req, res) -> compose.mailModel.get  req, res
        .post (req, res) -> compose.mailModel.post req, res


    router.get '*', (req, res) ->
      res.sendFile path.resolve './client/index.html'


    app.use '/', router
