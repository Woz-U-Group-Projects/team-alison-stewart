module CountryHelper
  def options_for_countries
    countries = Country.all.sort do |a,b|
      a.name <=> b.name
    end

    # Put Canada and the US at the top of the list
    countries.unshift(Country.find_country_by_alpha2('US'))
    countries.unshift(Country.find_country_by_alpha2('CA'))

    countries
  end

  def options_for_provinces
    countries = Country.all.sort do |a,b|
      a.name <=> b.name
    end

    provinces_map = []

    countries.each do |country|
      subdivisions = country.subdivisions.collect do |key, value|
        [value['name'], key, country.alpha2]
      end.sort do |a,b|
        a[0] <=> b[0]
      end

      subdivisions.each do |subdivision|
        provinces_map.push subdivision
      end
    end

    provinces_map
  end

  def country_long_name(country_code)
    Country.find_country_by_alpha2(country_code).name
    country_full_name = Country.find_country_by_alpha2(country_code).name
  end

  def province_long_name(province_code, country_code)
    country = Country.find_country_by_alpha2(country_code)
    province_full_name = country.subdivisions[province_code]['name']
  end
end
