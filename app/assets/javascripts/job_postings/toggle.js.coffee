$(document).ready ->
  $('.job-posting-list-item .job-title').each ->
    $this = $(this)
    state = false
    job_information = $this.next('div.job-information').slideUp()

    $this.click ->
      state = !state
      job_information.slideToggle state
      $this.toggleClass 'active', state
