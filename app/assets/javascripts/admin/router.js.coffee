window.Artona = {
  Views: {}
}

class Artona.Router
  constructor: ->
    path = window.location.pathname
    params = []
    if action = @routes[path]
    else
      $.each @routes, (key, value) =>
        pattern = key.replace new RegExp(@urlParamsPattern, 'g'), @urlParamValuePattern
        if matches = path.match new RegExp(pattern)
          action = value
          matches.splice(0, 1)
          params = matches

    action?.apply(@, params)

  urlParamsPattern: ':([a-zA-Z_0-9$]*)'
  urlParamValuePattern: '([^/]*)'

  routes:
    '/admin': ->
      new Artona.Views.DashboardView($el: $('#active_admin_content'))

    '/admin/demo_videos/:id': (id) ->
      new Artona.Views.ShowDemoVideoView($el: $('#active_admin_content'))

    '/admin/look_books/:id': (id) ->
      new Artona.Views.ShowLookBookView($el: $('#active_admin_content'))

    '/admin/products/:id': (id) ->
      new Artona.Views.ShowProductView($el: $('#active_admin_content'))

    '/admin/schools/:id': (id) ->
      new Artona.Views.ShowSchoolView($el: $('#active_admin_content'))

    '/admin/services/:id': (id) ->
      new Artona.Views.ShowServiceView($el: $('#active_admin_content'))

    '/admin/sittings/:id': (id) ->
      new Artona.Views.ShowSittingView($el: $('#active_admin_content'))
