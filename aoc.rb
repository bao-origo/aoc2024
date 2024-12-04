require 'net/http'
require 'uri'

module AOC
  def self.read(day)
    url = URI.parse("https://adventofcode.com/2024/day/#{day}/input")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true  # Use SSL/TLS.

    request = Net::HTTP::Get.new(url.request_uri)

    session_cookie = ENV['AOC_SESSION']
    if session_cookie
      request['Cookie'] = session_cookie
    else
      puts "Error: AOC_SESSION environment variable is not set."
      return nil
    end

    response = http.request(request)

    if response.is_a?(Net::HTTPSuccess)
      response.body
    else
      puts "Error fetching input: #{response.code} #{response.message}"
      nil
    end
  end
end
