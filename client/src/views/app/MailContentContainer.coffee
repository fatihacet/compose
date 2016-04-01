class compose.MailContentContainer extends compose.BaseView

  ###*
    Content container for the mail content. When user select a mail from the
    list a new `compose.MailContent` class will be instantiated and it will
    be rendered in this view's DOM element.

    @constructor
    @extends {compose.BaseView}
    @param {Object} options Configuration object.
    @param {Object} data Template data.
  ###
  constructor: (options = {}, data) ->

    options.template     = compose.templates.app.mailContentContainer
    options.templateData = data

    super options
