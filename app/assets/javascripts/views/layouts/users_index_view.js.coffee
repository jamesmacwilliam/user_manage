class um.UsersIndex extends Backbone.View
  template: ich.users_index

  el: '#application'

  events:
    'click tr[data-element="item"]':  'edit_line'
    'submit #edit_user'            :  'submit_form'
    'click th'                     :  'sort'

  render: =>
    @$el.html @.template
    @.render_items()
    @.render_pagination()

  render_items: =>
    table_body = $('tbody').empty()
    _.each @collection.models, (model) =>
      table_body.append new um.UserItem(model: model, el: table_body).render()

  edit_line: (e) =>
    e.preventDefault()
    edit_form = $('#edit_user')
    context = $(e.currentTarget).find('td')
    _.each context, (el) =>
      $el = $(el)
      type = $el.data('type')
      val = $el.html().trim()
      edit_form.find("input[data-edit='#{type}']").val(val)
    edit_form.css('display', 'block')

  submit_form: (e) =>
    e.preventDefault()
    model = @collection.get($('input[data-edit="id"]').val())
    edit_form = $('#edit_user')
    model_hash = {}
    _.each edit_form.find('input'), (input) =>
      model_hash[$(input).data('edit')] = $(input).val()
    model.save(model_hash,
      success: =>
        @collection.fetch(
          success: (response) =>
            @.render_items()
        )
    )
    edit_form.css('display', 'none')

  sort: (e) =>
    e.preventDefault()
    #@.render_pagination()
    sort_col = $(e.currentTarget)
    key = sort_col.data('item')
    direction = sort_col.data('direction') || 'asc'
    opposite_dir = if direction == 'asc' then 'desc' else 'asc'
    sort_col.data("direction", opposite_dir)
    @collection.params = _.extend(@collection.params, {sort_by: key, direction: direction})
    @collection.fetch(
      success: (response) =>
        @.render_items()
    )

  render_pagination: =>
    $('#table_footer').bootpag(
      page: 1
      total: um.total_pages
    ).on("page", (event, num) =>
      @collection.params = 
      @collection.params = _.extend(@collection.params, {page: num})
      @collection.fetch(
        success: (response) =>
          @.render_items()
      )
    )
