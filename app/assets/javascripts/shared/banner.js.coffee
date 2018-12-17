$(document).ready ->
  $('.hero__cycle div:gt(0)').hide()

  if $('.hero__cycle div').length > 1
    setInterval (->
      fadeTime = 1000

      $('.hero__cycle :first-child').fadeOut(fadeTime).next('div').fadeIn(fadeTime).end().appendTo '.hero__cycle'
    ), 5000
