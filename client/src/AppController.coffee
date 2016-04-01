class compose.AppController extends compose.EventEmitter

  ###*
    @constructor
    @extends {compose.EventEmitter}

    The main AppController. It will create the router and listen the route
    changes to draw the App and/or Welcome page. Also it will manage the `AppView`
    to control UI related stuff.
  ###
  constructor: ->

    super

    @router  = new compose.Router
    @appView = new compose.AppView

    @listenRouteChange()
    @checkAccount()
    @bindEvents()


  ###*
    Listen `Router` events and invoke the bound method on `AppView`.
    When adding routes to `Page` router, we injecting the handler to context.
    See `compose.Router::addRoutes`.
  ###
  listenRouteChange: ->

    @router.on 'RouteChanged', (context) =>
      data = { context, @account }
      @appView[context.routeHandler] data


  ###*
    Check LocalStorage for previously saved account data. If account data is
    found navigate to App, otherwise navigate to Welcome page to allow user to
    add their first email account.
  ###
  checkAccount: ->

    account = localStorage.getItem 'account'

    if account
      @setAccountData JSON.parse account
      @fetchMails()
      @router.navigate compose.ROUTES.app.route
    else
      @router.navigate compose.ROUTES.welcome.route


  ###*
    Decorate the data and store it in class level.
    @param {Object} data User account data.
  ###
  setAccountData: (data) ->

    data.hash = md5 data.email # Store hash to create Gravatar.
    @account  = data


  bindEvents: ->

    # User clicked the `Compose` button on the `Composer` UI.
    # Triggered from `compose.Composer` via the `MailSendRequested` event.
    @appView.on 'MailSendRequested', (data) => @composeMail data

    # User is added the account so check the data first then navigate to app.
    @appView.on 'AccountAdded', => @checkAccount()


  ###*
    Fetch mails from API and tell AppView to list them.
  ###
  fetchMails: ->

    $.ajax
      type    : 'GET'
      url     : "/api/mail?email=#{@account.email}"
      success : (mails) => @appView.listMails mails
      error   : -> # TODO: Error handling pls.


  ###*
    Make a request to server to send the mail.
    @param {Object} data Mail data which contains `from`, `to` etc. fields.
  ###
  composeMail: (data) ->

    $.ajax
      type     : 'POST'
      url      : '/api/mail'
      dataType : 'json'
      data     : data
      success  : (mail) => @appView.emit 'MailComposed', mail
      error    : -> # TODO: Error handling pls.
