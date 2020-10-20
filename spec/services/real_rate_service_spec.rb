require 'rails_helper'

class FakeResponse
  attr_accessor :code, :body
  def initialize(code, body)
    @code = code
    @body = body
  end
end

RSpec.describe 'DataServices::RealRate' do
  let(:true_body) do
    '<ValCurs Date="20.10.2020" name="Foreign Currency Market">
      <Valute ID="R01215">
        <NumCode>208</NumCode>
        <CharCode>DKK</CharCode>
        <Nominal>1</Nominal>
        <Name>Датская крона</Name>
        <Value>12,2882</Value>
      </Valute>
      <Valute ID="R01235">
        <NumCode>840</NumCode>
        <CharCode>USD</CharCode>
        <Nominal>1</Nominal>
        <Name>Доллар США</Name>
        <Value>77,9241</Value>
      </Valute>
    </ValCurs>'
  end
  let(:wrong_body) { 'Wrong body' }

  let(:response_with_true_data)  { FakeResponse.new('200', true_body) }
  let(:response_with_wrong_code) { FakeResponse.new('404', true_body) }
  let(:response_with_wrong_body) { FakeResponse.new('200', wrong_body) }

  describe 'method .create' do
    it 'with true data' do
      expect { DataServices::RealRate.create(response: response_with_true_data) }
        .to change(Rate, :count)
    end

    it 'with wrong code' do
      expect { DataServices::RealRate.create(response: response_with_wrong_code) }
        .to raise_error(DataServices::RealRate::RateSiteError)
    end

    it 'with wrong body' do
      expect { DataServices::RealRate.create(response: response_with_wrong_body) }
        .to raise_error(DataServices::RealRate::RateSiteError)
    end
  end
end
