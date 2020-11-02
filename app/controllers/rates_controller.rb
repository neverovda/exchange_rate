class RatesController < ApplicationController
  def show
    @price = Rails.cache.fetch('actual_rate_price') do
      Rate.actual&.price
    end
  end
end
