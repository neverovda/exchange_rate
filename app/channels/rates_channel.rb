class RatesChannel < ApplicationCable::Channel
  # def subscribed
  #   # stream_from "some_channel"
  # end

  # def unsubscribed
  #   # Any cleanup needed when channel is unsubscribed
  # end

  def follow
    stream_from 'rates'
  end
end
