class um.UsersRouter extends Backbone.Router
  routes:
    '':   'index'

  initialize: ->
    Backbone.history.start(pushState: true, hashChange: false, root: window.location.pathname)

  index: =>
    new um.UsersIndex(collection: um.users).render()
