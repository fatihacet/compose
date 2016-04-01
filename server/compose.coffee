utils             = require './utils'
config            = require './config'
mongoose          = require 'mongoose'
MailModel         = require './models/MailModel'
MailSender        = require './services/MailSender'
MailgunService    = require './services/MailgunService'
NodeMailerService = require './services/NodeMailerService'


module.exports =

  init: ->

    # Initiate MongoDB connection with Mongoose.
    mongoose.connect utils.getMongoUrl()
    mongoose.connection.once 'open', =>
      console.log 'DB is ready...'

      # Instantiate `MailSender` and register services in priority.
      # `mailSender` will be used in `mailModel` instance.
      mailSender = new MailSender
      mailSender.registerService new NodeMailerService, 0
      mailSender.registerService new MailgunService, 1

      # Instantiate `MailModel` to provide mail listing, composing etc.
      @mailModel = new MailModel mailSender
