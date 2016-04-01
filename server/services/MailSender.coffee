AbstractMailService = require './AbstractMailService'

module.exports = class MailSender

  ###*
    Main MailSender class. Register services with priorities then invoke `send`
    method. MailSender will take care of services and use a built-in failover
    mechanism so ideally app must use this sender class to send mails.

    @constructor
  ###
  constructor: ->

    @services = []
    @currentServiceIndex = 0


  ###*
    Register a service to sender. Priority will be used to determine which
    service will be used as main sender and which will be the failover service.

    @param {AbstractMailService} service An implementation of abstract service
    @param {number} priority Service priority. A service which has higher
    priority number will be the main service.
  ###
  registerService: (service, priority) ->

    unless service instanceof AbstractMailService
      message = 'Email Service must be an implementation of AbstractMailService'
      return throw new Error message

    @services.push [ service, priority ]
    @services.sort (c, n) -> return if c[1] < n[1] then 1 else -1

    @currentServiceIndex = 0
    @activeService = @getService()


  ###*
    Returns the current email service.

    @return {AbstractEmailService} Current email service.
  ###
  getService: ->

    service = @services[@currentServiceIndex] or []
    return service[0]


  ###*
    Increase the service index and return the next service.

    @return {AbstractEmailService} Current email service.
  ###
  getNextService: ->

    ++@currentServiceIndex
    return @getService()


  ###*
    Send mail using failover mechanism. If main service fails it will try to
    deliver the mail next available service and so on.

    @param {Object} data Message data.
    @param {Function} callback Repsonse handler.
  ###
  send: (data, callback) ->

    service     = @getService()
    isServiceUp = service.checkStatus()

    if isServiceUp
      service.send data, callback
    else
      # Handle service error. Try to get next service and try sending again
      # using the new service.
      if @getNextService()
        return @send data, callback

      # There is something wrong, all services are down.
      errObj   =
        code   : 500
        detail : 'No available service'
        message: 'There was a problem while sending your mail.'

      callback errObj
      @currentServiceIndex = 0 # Reset services index to start from first service.
