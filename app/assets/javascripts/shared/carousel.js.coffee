window.initializeCarousels = ->
  $(".carousel-photo").each ->
    # The default should match what is in look_book_helper.rb
    slides = parseInt($(this).attr('data-slides')) || 5
    center = !!$(this).attr('data-center')

    $(this).slick({
      centerMode: center,
      slidesToShow: slides,
      infinite: true,
      prevArrow: '<div class="carousel__left">
                    <i class="fa fa-angle-left carousel__icon"></i>
                  </div>',
      nextArrow: '<div class="carousel__right">
                    <i class="fa fa-angle-right carousel__icon"></i>
                  </div>',
      dots: true,
      dotsClass: 'slick-dots list list--horizontal',
      customPaging: (slider, i) ->
        '<img src="' + $(slider.$slides[i]).find('img').attr('src') + '"></img>';
      ,
      responsive: [
        {
          breakpoint: 1023,
          settings: {
            slidesToShow: Math.ceil((slides / 2)),
          }
        },
        {
          breakpoint: 767,
          settings: {
            slidesToShow: 1,
            dots: false
          }
        }
      ]
    });

$(document).ready ->
  window.initializeCarousels()
