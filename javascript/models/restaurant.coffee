class Gourmet.Models.Restaurant extends Backbone.Model

  urlRoot: '/restaurants'

  defaults:
    name: null
    postcode: null
    rating: null

  validate:
      name:
        required: true
      postcode:
        required: true
      rating:
        required: true
        type:     'number'
        min:      1
        max:      5

class Gourmet.Collections.RestaurantsCollection extends Backbone.Collection

  url: '/restaurants'

  model: Gourmet.Models.Restaurant
