require 'cgi'

class HashToQuery
  def self.convert(hash)
    hash.collect do |k,v|
      "#{k}=#{URI.encode(v || '')}"
    end.join('&')
  end
end
