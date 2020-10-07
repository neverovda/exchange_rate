class DataServices::RealRate
  class RateSiteError < StandardError; end

  SOURCE_URL = 'https://www.cbr-xml-daily.ru/daily.xml'
  CHAR_CODE = 'USD'

  def self.create
    response = Net::HTTP.get_response(URI(SOURCE_URL))
    raise RateSiteError unless response.is_a?(Net::HTTPSuccess) && response.code == '200'

    begin
      price = Hash.from_xml(response.body)['ValCurs']['Valute']
                  .find { |valute| valute['1CharCode'] == CHAR_CODE }['Value']
                  .tr(',', '.').to_f
    rescue
      raise RateSiteError
    end
    Rate.create price: price
  end
end
