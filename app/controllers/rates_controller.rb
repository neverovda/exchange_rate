class RatesController < ApplicationController
  def show
    @rate = Rate.last
  end
end
