url          = require 'url'
mongoose     = require 'mongoose'
EventEmitter = require 'events'


module.exports = class MailModel extends EventEmitter

  ###*
    Mail model constructor. Send the mail via service then saves it to MongoLab
    database. It also has REST API . `get` for listing mails of user and `post`
    for composing new mail.

    @constructor
    @extends {EventEmitter}
    @param {MailSender} sender An abstraction layer for mail services.
  ###
  constructor: (sender) ->

    # Create Mongoose schema and set validations.
    schema = new mongoose.Schema @getSchema()
    schema.set 'validateBeforeSave', yes

    # This model will be used to save and search mails, Mongoose powered.
    @model  = mongoose.model 'Mail', schema
    @sender = sender


  ###*
    Mail find method. Requires an email field in query string of the request
    and fetches emails for that email from DB and returns them as response JSON.

    @param {Object} req Express request object.
    @param {Object} res Express response object.
  ###
  get: (req, res) ->

    { email } = req.query

    @model.find({ from: email }).exec (err, mails) ->
      res.json mails


  ###*
    Create new mail, send it first using service API then save to DB.

    @param {Object} req Express request object.
    @param {Object} res Express response object.
  ###
  post: (req, res) ->

    { from, to, subject, text } = req.body
    data = { from, to, subject, text, body: text }

    @sender.send data, (err, response) =>
      if err
        console.log err
        return res.boom.badRequest 'There was an error while sendind the mail...'

      mail = new @model data
      mail.save (err, mail) -> res.json mail


  ###*
    Return mail model schema.

    @return {Object} Schema defination.
  ###
  getSchema: ->

    schema      =
      from      : type: String, required: yes, index: yes
      to        : type: String, required: yes, index: yes
      subject   : type: String, required: yes, index: yes
      body      : type: String, required: yes
      createdAt : type: Date,   default : Date.now

    return schema
