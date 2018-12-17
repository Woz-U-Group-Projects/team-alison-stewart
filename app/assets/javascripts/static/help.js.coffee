$(document).ready ->
  $('#faq_text').quicksearch('.frequently-asked-question-list-items .frequently-asked-question-list-item',
    'noResults': '.filter-empty'
  );

  $('#faq-filter').submit (event) ->
    event.preventDefault()

    $('html, body').animate({
        scrollTop: $('.frequently-asked-question-list-items').offset().top
    }, 1500);

  $('#job_posting_text').quicksearch('.job-posting-list-items .job-posting-list-item .job-title',
    'noResults': '.filter-empty'
  );

  $('#job-posting-filter').submit (event) ->
    event.preventDefault()

    $('html, body').animate({
        scrollTop: $('.job-posting-list-items').offset().top
    }, 1500);
