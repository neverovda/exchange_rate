class DataServices::RealRate
  def self.create
    Rate.create price: rand(0...99.99).round(2)
  end
end
