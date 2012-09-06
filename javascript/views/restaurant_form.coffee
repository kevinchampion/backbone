class Gourmet.Views.RestaurantForm extends Backbone.View
  events:
    'click #save': 'save'

  save: ->
    data = @parseFormData(@$el.serializeArray())
    new_restaurant = new Gourmet.Models.Restaurant data
    errors =  new_restaurant.validate(new_restaurant.attributes)
    if errors then @handleErrors(errors) else @collection.create new_restaurant

  parseFormData: (serialized_array) ->
    _.reduce serialized_array, @parseFormField, {}

  parseFormField: (collector, field_obj) ->
    name = field_obj.name.match(/\[(\w+)\]/)[1]
    collector[name] = field_obj.value
    collector

  handleErrors: (errors) ->
    $('.control-group').removeClass 'error'
    for key in (_.keys errors)
      do (key) ->
        input = $("#restaurant_#{key}")
        input.closest('.control-group').addClass 'error'
