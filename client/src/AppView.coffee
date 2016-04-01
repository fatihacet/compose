###*
  This is the parent class which deals with the UI flow. It is responsible to
  draw welcome page, switching to app view, listing mails, showing a mail
  content, creating the composer and anything related with the user action.
  Instantiated by the `compose.AppController` and listens orders from the AC.

  @constructor
  @extends {compose.EventEmitter}
###
class compose.AppView extends compose.EventEmitter

  ###*
    Draw Welcome page to allow user to add their first email account. When account
    is added detaches its view from DOM and forwards `AccountAdded` event to
    AppController to switch to App.
  ###
  drawWelcome: ->

    @welcomeView = new compose.WelcomeView
    @welcomeView.on 'AccountAdded', =>
      @welcomeView.detach()
      @emit 'AccountAdded'


  ###*
    Draw the main parts of the app which are Sidebar, MailList and MailContent.
    Bind related events like user interactions.
  ###
  drawApp: (data) ->

    @mailContentWidgets  = {} # Store already drawn mail content classes
    { context, account } = data
    @account             = account

    @appContainer     = document.createElement 'div'
    @appContainer.id  = 'main-container'

    # Create the main views
    renderConfig      = { renderTo: @appContainer }
    @sidebar          = new compose.Sidebar renderConfig, account
    @mailList         = new compose.MailList renderConfig, account
    @contentContainer = new compose.MailContentContainer renderConfig, account

    @bindAppEvents()

    document.body.appendChild @appContainer


  ###*
    Tell `mailList` to draw mails.
  ###
  listMails: (mails) -> @mailList.listMails mails


  bindAppEvents: ->

    # Show selected mail content on right pane.
    @mailList.on 'MailSelected', (mailListItem) => @showMail mailListItem

    # Create `compose.Composer` when user clicked the `Compose` button on sidebar.
    @sidebar.on  'ComposeRequested', => @createComposer()

    # A mail is composed, add it to list, select it and show it.
    @on 'MailComposed', (mail) =>
      item = @mailList.addMail mail, yes
      item.select()
      @mailList.noView.hide()
      @mailList.selectedItem?.deselect()
      @showMail mail


  ###*
    Show mail content on the right pane. It checks the existence of the widget
    before recreating. If it exists it will simply attach it back to DOM
    otherwise it will take an instance of `compose.MailContent` then attach to DOM.

    @param {Object} data Mail data to create content widget.
  ###
  showMail: (data) ->

    { _id } = data

    @activeContentWidget?.detach()
    @contentContainer.noView.hide()

    # If there is an already drawn widget, don't create another one reuse it
    # and append to DOM.
    if content = @mailContentWidgets[_id]
      content.attach()
      return @activeContentWidget = content

    # Create the content widget and cache it to reuse later.
    @activeContentWidget = new compose.MailContent
      renderTo     : @contentContainer.templateEl
      templateData : data

    @mailContentWidgets[_id] = @activeContentWidget


  ###*
    Show the `compose.Composer` to allow user to compose a new email.
    Detach it when mail composed.
  ###
  createComposer: ->

    composer = new compose.Composer templateData: @account

    composer.once 'MailSendRequested', (data) =>
      @emit 'MailSendRequested', data

    @on 'MailComposed', => composer.detach()
