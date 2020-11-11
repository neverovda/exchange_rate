require 'rails_helper'

RSpec.describe AdminRatesController, type: :controller do
  describe 'GET #new' do
    before do
      get :new
    end

    it 'assigns a new Rate to @rate' do
      expect(assigns(:rate)).to be_a_new(Rate)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new rate in the database' do
        expect { post :create, params: { rate: attributes_for(:rate, :forced)} }.to change(Rate, :count).by(1)
      end
      it 'redirects to show new' do
        post :create, params: { rate: attributes_for(:rate, :forced) }
        expect(response).to redirect_to action: :new
      end
    end

    context 'with invalid attributes' do
      it 'dose not save the rate' do
        expect { post :create, params: { rate: attributes_for(:rate, :forced_invalid) } }
          .to_not change(Rate, :count)
      end
      it 're-renders new view' do
        post :create, params: { rate: attributes_for(:rate, :forced_invalid) }
        expect(response).to render_template :new
      end
    end
  end
end
