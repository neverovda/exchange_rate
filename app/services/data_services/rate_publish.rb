class DataServices::RatePublish
  def self.call(value)
    Rails.cache.write('actual_rate_value', value)
    ActionCable.server.broadcast 'rates', value
  end
end
