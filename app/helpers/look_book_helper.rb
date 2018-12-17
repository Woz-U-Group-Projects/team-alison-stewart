module LookBookHelper
  # Constants
  # This should match what is in carousel.js.coffee
  MAX_CAROUSEL_SIZE = 5

  def carousel_length(count)
    count >= MAX_CAROUSEL_SIZE ? MAX_CAROUSEL_SIZE : count
  end

  def carousel_highlighted?(count)
    carousel_length(count) >= MAX_CAROUSEL_SIZE
  end
end
