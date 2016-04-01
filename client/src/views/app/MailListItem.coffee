class compose.MailListItem extends compose.BaseView

  ###*
    A class which represents mail items on UI. Every single mail item on the
    mail list is an instance of this class.

    @constructor
    @extends {compose.BaseView}
    @param {Object} options Configuration object.
  ###
  constructor: (options = {}) ->

    options.template = compose.templates.app.mailListItem

    super options


  ###*
    Show mail as selected on UI.
  ###
  select: -> @templateEl.classList.add 'selected'


  ###*
    Revert selection. Remove selected class.
  ###
  deselect: -> @templateEl.classList.remove 'selected'
