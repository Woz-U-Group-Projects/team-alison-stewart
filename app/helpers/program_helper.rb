module ProgramHelper
  def program_icon(program_slug)
    case program_slug
    when Program::GRADUATION_SLUG
      'fa-graduation-cap'
    when Program::SCHOOL_PHOTO_SLUG
      'fa-camera-retro'
    when Program::CONVOCATION_SLUG
      'fa-book'
    else
      ''
    end
  end

  def program_image(program_slug)
    case program_slug
    when Program::GRADUATION_SLUG
      'models/graduation-1.jpg'
    when Program::SCHOOL_PHOTO_SLUG
      'models/schoolday-1.jpg'
    when Program::CONVOCATION_SLUG
      'models/convocation-2.jpg'
    else
      ''
    end
  end
end
