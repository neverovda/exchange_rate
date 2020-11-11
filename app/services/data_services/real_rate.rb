class DataServices::RealRate
  class RateSiteError < StandardError; end

  SOURCE_URL = 'https://www.cbr-xml-daily.ru/daily.xml'
  CHAR_CODE = 'USD'

  class << self
    def create(response: default_response)
      raise RateSiteError unless response.code == '200'

      begin
        value = Hash.from_xml(response.body)['ValCurs']['Valute']
                    .find { |valute| valute['CharCode'] == CHAR_CODE }['Value']
                    .tr(',', '.').to_f
      rescue StandardError
        raise RateSiteError
      end
      Rate.create value: value
      DataServices::RatePublish.call value unless Rate.forced?
    end

    private

    def default_response
      Net::HTTP.get_response(URI(SOURCE_URL))
    end
  end
end
