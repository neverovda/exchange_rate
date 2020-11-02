require 'rails_helper'

RSpec.describe RatesController, type: :controller do
  describe 'GET #show' do
    it "assigns rate's price not forced" do
      rate = create(:rate)
      forced_rate = build(:rate, :forced_not_actual)
      forced_rate.save(validate: false)
      get :show
      expect(assigns(:price)).to eq(rate.price)
    end

    it "assigns rate's price forced" do
      _rate = create(:rate)
      forced_rate = create(:rate, :forced)
      get :show
      expect(assigns(:price)).to eq(forced_rate.price)
    end

    it 'renders the show template' do
      get :show
      expect(response).to render_template('show')
    end
  end
end
