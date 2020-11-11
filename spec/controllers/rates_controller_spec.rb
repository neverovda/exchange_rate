require 'rails_helper'

RSpec.describe RatesController, type: :controller do
  describe 'GET #show' do
    let!(:rate) { create(:rate) }

    it "assigns rate's value not forced" do
      forced_rate = build(:rate, :forced_not_actual)
      forced_rate.save(validate: false)
      get :show
      expect(assigns(:value)).to eq(rate.value)
    end

    it "assigns rate's value forced" do
      forced_rate = create(:rate, :forced)
      get :show
      expect(assigns(:value)).to eq(forced_rate.value)
    end

    it 'renders the show template' do
      get :show
      expect(response).to render_template('show')
    end
  end
end
