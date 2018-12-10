module Utils
  # Constants
  FACEBOOK_PAGE_ID = 53396785771
  FACEBOOK_WEB_URL = "https://www.facebook.com/ArtonaGroup/"
  FACEBOOK_ANDROID_URL = "fb://page/#{FACEBOOK_PAGE_ID}"
  FACEBOOK_IOS_URL = "fb://profile/#{FACEBOOK_PAGE_ID}"
  INSTAGRAM_URL = "https://www.instagram.com/artonagroup/"
  TWITTER_URL = "https://twitter.com/Artona"

  # Facebook Page URL
  def self.generate_facebook_url(android, ios)
    if android
      FACEBOOK_ANDROID_URL
    elsif ios
      FACEBOOK_IOS_URL
    else
      FACEBOOK_WEB_URL
    end
  end

  # Photography methods
  def self.photography_year(format = '%y')
    # set to coincide with financial year-end (visual customer ID record)
    5.months.from_now.strftime(format)
  end

  def self.graduation_years(format = '%Y')
    # graduation years for selection are set to rotate every year on Sept 1. The selections are the year before, the "current" year and the following two years after that.
    [8.months.ago.strftime(format), 4.months.from_now.strftime(format), 16.months.from_now.strftime(format), 28.months.from_now.strftime(format)]
  end

  def self.short_year(year)
    year = year.split('')
    year.shift
    year.shift
    year.join('')
  end
end
