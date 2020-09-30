class Rate < ApplicationRecord
  after_create

  after_create :publish

  private

  def publish
    ActionCable.server.broadcast 'rates', '100'
  end
end
