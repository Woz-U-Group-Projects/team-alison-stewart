class Artona.Views.BaseView
  constructor: (options) ->
    if options && options.$el
      @$el = options.$el
      @initialize() if @$el.length > 0
    else
      throw new Error('Must define an element \'$el\' option to scope the view to a region on the screen')

  initialize: ->
    throw new Error('Initialize method must be implemented for all views!')

  $: (selector) ->
    @$el.find(selector)
