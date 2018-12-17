$(document).ready ->
  $('.frequently-asked-question-list-item .question').each ->
    $this = $(this)
    state = false
    answer = $this.next('div.answer').slideUp()

    $this.click ->
      state = !state
      answer.slideToggle state
      $this.toggleClass 'active', state
