$(document).ready ->
  openResponsiveNav = ->
    $nav = $(".header__responsive-nav")

    $nav.css("left", "0")

  closeResponsiveNav = ->
    $nav = $(".header__responsive-nav")

    $nav.css("left", "-250px")

  $(".header__responsive-link-container").on "click", (event) ->
    openResponsiveNav()
    event.stopPropagation()

  $(".header__responsive-nav").on "click touchstart", (event) ->
    event.stopPropagation()

  $("body").on "click touchstart", (event) ->
    closeResponsiveNav()
