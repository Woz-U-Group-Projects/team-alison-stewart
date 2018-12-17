$(document).ready ->
  (($) ->
    $.fn.removeInlineStyle = (style) ->
      search = new RegExp(style + '[^;]+;?', 'g')
      @each ->
        $(this).attr 'style', (i, style) ->
          style.replace search, ''
        return

    return
  ) jQuery