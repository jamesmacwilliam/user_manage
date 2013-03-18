class um.UsersCollection extends Backbone.Collection
  url: 'users'

  model: um.User

  collection_name: 'users'

  params: {}

  fetch: (args) =>
    super(_.extend(args, {data: @params}))
