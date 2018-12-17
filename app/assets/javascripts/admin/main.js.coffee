$ ->
  # Initialize all select2 selects
  $('.select2').select2(
    matcher: (params, data) ->
      # Custom matcher so that we can match optgroups as well
      if $.trim(params.term) == ''
        return data

      if data.text.toUpperCase().indexOf(params.term.toUpperCase()) > -1
        modifiedData = $.extend({}, data, true)
        return modifiedData

      null
  );

  # Initialize all color pickers
  $('.color-picker').minicolors()

  router = new Artona.Router
