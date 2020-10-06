class RatesController < ApplicationController
  def show
    @rate = Rate.actual
  end
end
