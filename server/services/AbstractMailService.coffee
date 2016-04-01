module.exports = class AbstractMailService

  ###*
    Check service status. Currently returns yes as default for demo purposes.

    @return {Boolean} Service status.
  ###
  checkStatus: -> return yes


  ###*
    Send method of the service. Child classes must implement it.

    @param {Object} data Mail data.
    @param {Function} callback Response handler.
  ###
  send: (data, callback) ->
