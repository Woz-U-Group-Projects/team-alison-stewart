class Artona.Views.ShowDemoVideoView extends Artona.Views.BaseView
  initialize: ->
    $(".sortable-features-table").sortable
      items: "tr.feature"
      placeholder: "feature-droppable-highlight"
      forceHelperSize: true
      forcePlaceholderSize: true
      cursor: "move"
      appendTo: "body"
      opacity: 0.5
      helper: (event, ui) ->
        "<div id=\"feature-drag-helper\"><p>" + ui.html() + "</p></div>"
      update: @updateSortFeatures

  updateSortFeatures: =>
    features = []
    $(".feature").each (i) ->
      featureId = @id.split("-").reverse()[0]
      features.push "features[" + featureId + "][position]=" + (i+1)

    $.post window.location.pathname + "/update_features_position", features.join("&"), ->
