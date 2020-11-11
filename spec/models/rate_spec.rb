require 'rails_helper'

RSpec.describe Rate, type: :model do
  it { should validate_presence_of :value }
  it { should validate_numericality_of(:value).is_greater_than(0) }

  describe 'validate method expiration_at_cant_be_earlier_than_now' do
    let(:rate) { Rate.create(expiration_at: Time.now + 1.hour) }
    let(:not_valid_rate) { Rate.new(expiration_at: Time.now - 1.hour) }

    it 'valid rate' do
      rate.valid?
      expect(rate.errors[:expiration_at]).not_to include("can't be earlier than now")
    end

    it 'not valid rate' do
      not_valid_rate.valid?
      expect(not_valid_rate.errors[:expiration_at]).to include("can't be earlier than now")
    end
  end
end
