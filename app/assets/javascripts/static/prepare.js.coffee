$(document).ready ->
  setPrepare = (slug) ->
    $('[program-dependant]').each ->
      if $(this).attr(slug) isnt undefined
        $(this).removeInlineStyle('display')
      else
        $(this).css('display', 'none');

    $('html, body').animate({
      scrollTop: $(".start").offset().top
    }, 500)

  getParameterByName = (name, url) ->
    if !url
      url = window.location.href
    name = name.replace(/[\[\]]/g, '\\$&')
    regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)')
    results = regex.exec(url)

    if !results
      return null
    if !results[2]
      return ''

    decodeURIComponent results[2].replace(/\+/g, ' ')

  $('#program_program_slug').on 'change', (e) ->
    slug = $(this).val()

    setPrepare(slug)

  # If we are dropping right into a specific prepare section,
  # click on that section in the drop down.
  $("#program_program_slug").val(getParameterByName('program_slug'))
