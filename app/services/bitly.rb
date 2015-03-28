class Bitly
  BitlyAPIError = Class.new(StandardError)

  API_ENDPOINT = 'https://api-ssl.bitly.com'

  ACCESS_TOKEN = 'e09f21a512a337a3e6c9d6e7daa05d18d534a2ec'

  def initialize
    @session = Faraday.new(API_ENDPOINT) do |s|
      s.request :url_encoded
      s.adapter Faraday.default_adapter
    end
  end

  def shorten_url(long_url)
    shorten = @session.get do |g|
      g.url '/v3/shorten'
      g.params['access_token'] = ACCESS_TOKEN
      g.params['longUrl'] = long_url
    end

    raise BitlyAPIError unless shorten.status < 400

    data = JSON.parse(shorten.body)

    data['data']['url']
  end
end