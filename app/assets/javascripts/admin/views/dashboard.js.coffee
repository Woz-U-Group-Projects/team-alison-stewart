class Artona.Views.DashboardView extends Artona.Views.BaseView
  initialize: ->
    @_initSchoolSelector()

  _initSchoolSelector: ->
    $('#school_select_school_code').on 'change', (event) ->
      id = event.currentTarget.value

      window.location = "/admin/schools/#{id}"
