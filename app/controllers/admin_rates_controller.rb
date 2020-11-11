class AdminRatesController < ApplicationController
  def new
    @rate = Rate.new(last_params)
  end

  def create
    @rate = DataServices::ForcedRate.create(rate_params)

    if @rate.errors.blank?
      redirect_to({ action: 'new' }, notice: "Rate #{@rate.value} was successfully created.")
    else
      render :new
    end
  end

  private

  def rate_params
    params.require(:rate).permit(:value, :expiration_at)
  end

  def last_params
    rate = Rate.forced_last
    return unless rate

    { value: rate.value, expiration_at: rate.expiration_at }
  end
end
