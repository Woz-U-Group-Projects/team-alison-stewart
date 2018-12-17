$(document).ready ->
  openModal = (id) ->
    $modal = $("##{id}")

    if $modal
      $modal.css("visibility", "visible")
      $modal.css("opacity", "100")

      # Start the video if present
      $video = $modal.find('video')
      if $video.get(0)
        $video.get(0).play()

  closeModal = (id) ->
    $modal = $("##{id}")

    if $modal
      $modal.css("visibility", "hidden")
      $modal.css("opacity", "0")

      # Stop the video if present
      $video = $modal.find('video')
      if $video.get(0)
        $video.get(0).pause()

  toggleModal = (id) ->
    $modal = $("##{id}")

    if $modal
      if $modal.css("visibility") is "hidden"
        openModal(id)
      else
        closeModal(id)

  $("[data-modal-id]").each ->
    $(this).on "click", (event) ->
      toggleModal($(this).data("modal-id"))

      event.preventDefault()

  $(".modal__close").each ->
    $(this).on "click", (event) ->
      findModalParent = ($child) ->
        if $child.hasClass("modal") || $child is null
          return $child
        else
          findModalParent($child.parent())

      $modal = findModalParent($(this))

      closeModal($modal.attr("id"))

  $(".modal .container").each ->
    $(this).on "click", (event) ->
      event.stopPropagation()

  $(".modal").each ->
    $(this).on "click", (event) ->
      closeModal($(this).attr("id"))
