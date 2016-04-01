AbstractMailService = require './AbstractMailService'
config              = require '../config'
mailgun             = require 'mailgun-js'


module.exports = class MailgunService extends AbstractMailService

  ###*
    Mailgun service implementation.

    @constructor
    @extends {AbstractMailService}
  ###
  constructor: ->

    { @apiKey, @domain } = config.mailgun.credentials
    @mailgun = mailgun { @apiKey, @domain }


  send: (data, callback) ->

    { from, to, subject, text } = data  # expose fields
    mailData = { from, to, subject, text } # create a new object with only required fields.

    @mailgun.messages().send mailData, (err, response) ->
      callback err, response
