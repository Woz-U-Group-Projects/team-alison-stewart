class Artona.Views.ShowServiceView extends Artona.Views.BaseView
  initialize: ->
    $(".sortable-photos-table").sortable
      items: "tr.photo"
      placeholder: "photo-droppable-highlight"
      forceHelperSize: true
      forcePlaceholderSize: true
      cursor: "move"
      appendTo: "body"
      opacity: 0.5
      helper: (event, ui) ->
        "<div id=\"photo-drag-helper\"><p>" + ui.html() + "</p></div>"
      update: @updateSortPhotos

  updateSortPhotos: =>
    photos = []
    $(".photo").each (i) ->
      photoId = @id.split("-").reverse()[0]
      photos.push "photos[" + photoId + "][position]=" + (i+1)

    $.post window.location.pathname + "/update_photos_position", photos.join("&"), ->
