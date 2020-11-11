class RatesController < ApplicationController
  def show
    @value = Rails.cache.fetch('actual_rate_value') do
      Rate.actual&.value
    end
  end
end
