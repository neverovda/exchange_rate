class RatesController < ApplicationController
  def show
    @rate = Rate.last
    ActionCable.server.broadcast 'rates', '100'
  end
end
