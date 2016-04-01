class compose.Sidebar extends compose.BaseView

  ###*
    Sidebar of the app.

    @constructor
    @extends {compose.BaseView}
    @param {Object} options Configuration object.
    @param {Object} data Template data.
  ###
  constructor: (options = {}, data) ->

    options.template     = compose.templates.app.sidebar
    options.templateData = data

    super options


  bindEvents: ->

    # Initiate Compose action.
    @get('#compose-button').on 'click', => @emit 'ComposeRequested'
