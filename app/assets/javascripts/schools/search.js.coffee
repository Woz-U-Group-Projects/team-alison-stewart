$(document).ready ->
  $('#school_name').autocomplete
    source: (request, response) ->
      $.getJSON('/schools', { search: $('#school_name').val() }, (data) ->
          response(data.data.map (school) -> school.attributes.name)
        )
    delay: 250
    select: (event, ui) ->
      $('#school_name').val(ui.item.value)
      $('#school-search').submit()
