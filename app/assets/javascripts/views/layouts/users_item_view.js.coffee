class um.UserItem extends Backbone.View
  template: ich.user_item

  render: =>
    @$el.append @.template(@model.attributes)
