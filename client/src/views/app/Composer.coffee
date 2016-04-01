class compose.Composer extends compose.BaseView

  ###*
    Mail compose widget.

    @constructor
    @extends {compose.BaseView}
    @param {Object} options Configuration object.
  ###
  constructor: (options = {}) ->

    options.template = compose.templates.compose.widget
    options.renderTo = document.body

    super options


  bindEvents: ->

    toInput      = @get '#toInput'
    toAvatar     = @get '#toAvatar'
    sendButton   = @get '#send'
    cancelButton = @get '#cancel'
    composeForm  = document.forms.composeForm

    # Detach from DOM when cancelled.
    cancelButton.on 'click', => @detach()

    # Focus input when created and update the gravatar when `To` input is updated.
    toInput.focus()
    toInput.on 'change', =>
      toAvatar.show().attr 'src', "https://s.gravatar.com/avatar/#{md5(toInput.val())}"

    sendButton.on 'click', (e) =>
      return if @isComposing # Prevent reposting to server.

      if composeForm.checkValidity()
        e.preventDefault()
        sendButton.addClass('sending').text 'SENDING ...'
        @isComposing = yes

        { to, subject, body } = composeForm.elements
        formData  =
          to      : to.value
          subject : subject.value
          text    : body.value
          from    : @options.templateData.email

        # AppView will listen this event and forward it to AppController.
        @emit 'MailSendRequested', formData
