require 'rails_helper'
require 'sidekiq/testing'

def select_date_and_time(date, options = {})
  field = options[:from]
  select date.strftime('%Y'),  :from => "#{field}_1i" #year
  select date.strftime('%B'),  :from => "#{field}_2i" #month
  select date.strftime('%-d'), :from => "#{field}_3i" #day 
  select date.strftime('%H'),  :from => "#{field}_4i" #hour
  select date.strftime('%M'),  :from => "#{field}_5i" #minute
end

feature 'Admin can create forced rate' do
  given!(:rate) { create :rate }

  scenario "Forced Rate replace real rate on user's page", js: true do
    Sidekiq::Testing.fake!

    Capybara.using_session('admin') do
      visit admin_path
    end

    Capybara.using_session('user') do
      visit u_path
    end

    Capybara.using_session('admin') do
      fill_in 'rate_price', with: '77.77'
      select_date_and_time(Time.now + 60.second, from: 'rate_expiration_at')
      click_on 'Create Rate'
      sleep 1
      expect(page).to have_content 'was successfully created'
    end

    Capybara.using_session('user') do
      expect(page).to have_content '77.77'
      expect(page).not_to have_content rate.price
    end
  end

  scenario "Real Rate replace forced rate on user's page", js: true do
    Sidekiq::Testing.inline!

    Capybara.using_session('admin') do
      visit admin_path
    end

    Capybara.using_session('user') do
      visit u_path
    end

    Capybara.using_session('admin') do
      fill_in 'rate_price', with: '77.77'
      select_date_and_time(Time.now + 60.second, from: 'rate_expiration_at')
      sleep 1
      click_on 'Create Rate'
    end

    Capybara.using_session('user') do
      expect(page).not_to have_content '77.77'
      expect(page).to have_content rate.price
    end
  end
end
