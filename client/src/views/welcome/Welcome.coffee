class compose.WelcomeView extends compose.BaseView

  ###*
    Initial view of the app allows user to set up first email account.

    @constructor
    @extends {compose.BaseView}
    @param {Object} options Configuration object.
  ###
  constructor: (options = {}) ->

    options.template = compose.templates.welcome.welcome
    options.renderTo = document.body

    super options


  bindEvents: ->

    form = document.forms.accountForm
    { name, email, addAccountButton } = form.elements
    gravatar = @get '#account-gravatar', yes

    # Update gravatar
    @get(email).on 'change', ->
      gravatar.src = "https://s.gravatar.com/avatar/#{md5(email.value)}"

    @get(addAccountButton).on 'click', (e) =>
      if form.checkValidity()
        e.preventDefault()

        accountData =
          email     : email.value
          name      : name.value

        # Store the data on the LocalStorage
        localStorage.setItem 'account', JSON.stringify accountData

        # Emit `AccountAdded` to switch to App.
        @emit 'AccountAdded', accountData
