class Gourmet.Views.RestaurantsView extends Backbone.View
  events:
    'click .remove': 'removeRestaurant'
  template: Hogan.compile $('#restaurant-template').html()
  initialize: ->
    @render @collection
  render: =>
    @$el.empty()
    for restaurant in @collection.models
      do (restaurant) =>
        @$el.append @template.render(restaurant.toJSON())
  initialize: ->
    @render @collection
    @collection.on 'add', @render
    @collection.on 'remove', @render
  removeRestaurant: (evt) =>
    id = evt.target.id
    model = @collection.get id
    @collection.remove model
    model.destroy()
