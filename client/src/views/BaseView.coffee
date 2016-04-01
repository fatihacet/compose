class compose.BaseView extends compose.EventEmitter

  ###*
    Base view class which implements some helper methods for child classes.

    @constructor
    @extends {compose.EventEmitter}
    @param {Object} options Configuration object.
  ###
  constructor: (options = {}) ->

    super

    @options = options

    @render()
    @bindEvents()


  ###*
    Converts given template into a DOM element and attach it to render target.
  ###
  render: ->

    { renderTo, template, templateData } = @options

    return if not renderTo or not template

    unless renderTo instanceof Node
      throw new Error 'renderTo option must be a Node instance.'

    @template   = $ template templateData
    @templateEl = @template[0]
    @noView     = @template.find '.no-view'
    @loading    = @template.find '.loading'

    @attach()


  ###*
    Attach view's template element to DOM. Append or prepend is configurable.
  ###
  attach: ->

    { renderTo, prepend } = @options

    if prepend
      renderTo.insertBefore @templateEl, renderTo.firstChild
    else
      renderTo.appendChild @templateEl


  ###*
    Remove template element from DOM.
  ###
  detach: -> @templateEl.parentNode.removeChild @templateEl


  ###*
    Wrapper for querying DOM elements in this view's template element.

    @param {string} selector DOM query selector.
    @param {Boolean=} asElement Return plain DOM element or jQuery Object.
  ###
  get: (selector, asElement) ->

    $el = @template.find selector

    return if asElement then $el[0] else $el


  ###*
    A method called in constructor when view is attached to DOM.
    Subclasses must override it if they want to bind events when view is ready.
  ###
  bindEvents: ->
