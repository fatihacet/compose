class compose.MailList extends compose.BaseView

  ###*
    Container for mail items on UI and also manages mail listing logic.

    @constructor
    @extends {compose.BaseView}
    @param {Object} options Configuration object.
    @param {Object} data Template data.
  ###
  constructor: (options = {}, data) ->

    options.template     = compose.templates.app.mailList
    options.templateData = data

    super options


  ###*
    Check the given `mails` length and list mails if there are any. Otherwise
    show no view.

    @param {Array.<Object>} mails An array of user mails.
  ###
  listMails: (mails) ->

    if mails.length is 0
      @noView.show()
      return @loading.hide()

    mails.reverse().forEach (mail) => @addMail mail
    @loading.hide()


  ###*
    Create a `compose.MailListItem` instance and append it to mail list.
    Bind required events for managing mail selection/deselection.

    @param {Object} data Mail data.
    @param {Boolean=} prepend Whether show the new mail at top or bottom.
  ###
  addMail: (data, prepend) ->

    { to, body, createdAt, subject } = data

    # Decorate data before sending to template
    data.hash    = md5 to
    data.summary = if body.length > 80 then "#{body.substring 0, 80}..." else body
    data.date    = $.timeago new Date createdAt

    item = new compose.MailListItem
      prepend     : prepend
      renderTo    : @templateEl
      templateData: data

    item.template.on 'click', =>
      # Early return if the same mail is selected.
      return if @selectedItem is item

      item.select()
      @selectedItem?.deselect()
      @selectedItem = item
      @emit 'MailSelected', data

    return item
