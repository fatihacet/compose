class compose.EventEmitter extends EventEmitter

  ###*
    EventEmitter wrapper for our app. See the comment in `constructor` body.

    @constructor
    @extends {EventEmitter}
  ###
  constructor: ->

    super

    # If you return `true` from a listener, EventEmitter will treat it as a
    # `once` listener and remove it from event list when it's triggered.
    # https://github.com/Olical/EventEmitter/issues/50
    @setOnceReturnValue 'remove_event'
