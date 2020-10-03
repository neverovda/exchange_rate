class AdminRatesController < ApplicationController
  def new
    @rate = Rate.new(last_params)
  end

  def create
    @rate = Rate.new(rate_params)

    if @rate.save
      redirect_to({ action: 'new' }, notice: "Rate #{@rate.price} was successfully created.")
    else
      render :new
    end
  end

  private

  def rate_params
    params.require(:rate).permit(:price, :to)
  end

  def last_params
    rate = Rate.order("created_at").last
    { price: rate.price, to: rate.to }
  end
end
