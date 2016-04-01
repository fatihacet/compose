###*
  Routes of the app. They will be registered when `compose.Router` instantiated.
  A simple route consists from a `route` string which is the actuall route and
  a `handler` string which must be a method name in `compose.AppView`.
###
compose.ROUTES  =
  welcome : { route: '/welcome', handler: 'drawWelcome' }
  app     : { route: '/app',     handler: 'drawApp'     }


class compose.Router extends compose.EventEmitter

  ###*
    Router wrapper for the app. It uses `Page` router behind the scene but this
    class is `Page` plus application logic. Basically it will register routes
    when instantiated and then user navigates to one of those routes it will
    emit an `RouteChanged` event. `compose.AppController` will listen it and
    delegate to `compose.AppView` to do UI related stuff.
  ###
  constructor: ->

    super

    @addRoutes()


  ###*
    Register `compose.ROUTES` to Page route. Emit `RouteChanged` event as the
    main route handler.
  ###
  addRoutes: ->

    for key, routeInfo of compose.ROUTES
      { route, handler } = routeInfo

      do (route, handler) =>
        page route, (context) =>
          # Inject `compose.AppView`'s handler method to context.
          # `compose.AppController` will use it.
          context.routeHandler = handler
          @emit 'RouteChanged', context


  ###*
    Fancy named method to navigate between pages.

    @param {string} to Route path, must be defined in `compose.ROUTES`.
  ###
  navigate: (to) -> page to
