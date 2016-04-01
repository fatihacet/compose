AbstractMailService = require './AbstractMailService'
nodemailer          = require 'nodemailer'


module.exports = class NodeMailerService extends AbstractMailService

  ###*
    Nodemailer service implementation.

    @constructor
    @extends {AbstractMailService}
  ###
  send: (data, callback) ->

    { from, to, subject, text, username, email, password } = data
    transportString = "smtps://#{email}:#{password}@smtp.gmail.com"
    transporter     = nodemailer.createTransport transportString
    mailData        = { from, to, subject, text }

    transporter.sendMail mailData, (response) ->

      if response.responseCode > 0 # Error handling
        return callback response.response

      callback null, response
