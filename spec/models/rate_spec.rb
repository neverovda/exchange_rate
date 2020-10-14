require 'rails_helper'

RSpec.describe Rate, type: :model do
  it { should validate_presence_of :price }
end
