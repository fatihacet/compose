class compose.MailContent extends compose.BaseView

  ###*
    A view class for the mail content on the right pane.

    @constructor
    @extends {compose.BaseView}
    @param {Object} options Configuration object.
  ###
  constructor: (options = {}) ->

    options.template = compose.templates.app.mailContent

    super options
