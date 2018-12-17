$(document).ready ->
  $(".flash").each ->
    setTimeout(=>
      $(this).css("opacity", "0")
      $(this).css("visibility", "hidden")
    , 5000)
