$(document).ready ->
  $('form').on 'submit', (e) ->
    $form = $(this)

    if $form.data('submitted') is true
      # Previously submitted - don't submit again
      e.preventDefault()
    else
      # Mark it so that the next submit can be ignored
      $form.data 'submitted', true
