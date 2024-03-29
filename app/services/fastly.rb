class Fastly
  FASTLY_API_BASE_URL = 'https://api.fastly.com'

  FASTLY_APP_SERVICE = ENV['FASTLY_SERVICE_ID']

  def self.purge_key(key)
    session = create_fastly_session

    session.post do |p|
      p.url "/service/#{FASTLY_APP_SERVICE}/purge/#{key}"
    end
  end

  def self.purge_all
    session = create_fastly_session

    session.post do |p|
      p.url "/service/#{FASTLY_APP_SERVICE}/purge_all"
    end
  end

  private

  def self.create_fastly_session
    Faraday.new(FASTLY_API_BASE_URL) do |s|
      s.request :url_encoded
      s.adapter Faraday.default_adapter
    end
  end
end