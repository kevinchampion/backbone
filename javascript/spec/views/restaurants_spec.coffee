describe "Restaurants view", ->

  restaurants_data = [
    {
      id: 0
      name: 'Ritz'
      postcode: 'N112TP'
      rating: 5
    },
    {
      id: 1
      name: 'Astoria'
      postcode: 'EC1E4R'
      rating: 3
    },
    {
      id: 2
      name: 'Waldorf'
      postcode: 'WE43F2'
      rating: 4
    }
  ]

  invisible_table = document.createElement 'table'

  beforeEach ->
    @server = sinon.fakeServer.create()
    @restaurants_collection = new Gourmet.Collections.RestaurantsCollection restaurants_data
    @restaurants_view = new Gourmet.Views.RestaurantsView
      collection: @restaurants_collection
      el: invisible_table

  afterEach ->
    @server.restore()

  it "should be defined", ->
    expect(Gourmet.Views.RestaurantsView).toBeDefined()

  it "should have the right element", ->
    expect(@restaurants_view.el).toEqual invisible_table

  it "should have the right collection", ->
    expect(@restaurants_view.collection).toEqual @restaurants_collection

  it "should render the the view when initialized", ->
    expect($(invisible_table).children().length).toEqual 3

  it "should render when an element is added to the collection", ->
    @restaurants_collection.add
      name: 'Panjab'
      postcode: 'N2243T'
      rating: 5
    expect($(invisible_table).children().length).toEqual 4

  it "should render when an element is removed from the collection", ->
    @restaurants_collection.pop()
    expect($(invisible_table).children().length).toEqual 2

  it "should remove the restaurant when clicking the remove icon", ->
    remove_button = $('.remove', $(invisible_table))[0]
    $(remove_button).trigger 'click'
    removed_restaurant = @restaurants_collection.get remove_button.id
    expect(@restaurants_collection.length).toEqual 2
    expect(@restaurants_collection.models).not.toContain removed_restaurant

  it "should remove a restaurant from the collection", ->
    evt = { target: { id: 1 } }
    @restaurants_view.removeRestaurant evt
    expect(@restaurants_collection.length).toEqual 2

  it "should send an ajax request to delete the restaurant", ->
    evt = { target: { id: 1 } }
    @restaurants_view.removeRestaurant evt
    expect(@server.requests.length).toEqual 1
    expect(@server.requests[0].method).toEqual('DELETE')
    expect(@server.requests[0].url).toEqual('/restaurants/1')



