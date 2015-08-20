require 'rails_helper'

describe 'Authenticating', type: :feature do
  describe 'Logging In' do
    before do
      log_in_to_okta('email@blah.com')
    end

    it 'allows you to log in and view the dashboard' do
      visit '/login'
      expect(page).to have_content('Log in with Okta')
      click_on 'Log in with Okta'
      expect(page).to have_content('Whiteboard')
      expect(page).to have_content('Choose a Standup'.upcase)
    end
  end

  describe 'Logging Out' do
    before do
      log_in_to_okta('email@blah.com')
      visit '/login'
      click_on 'Log in with Okta'
    end

    it 'allows you to login and view the dashboard' do
      expect(page).to have_content('Whiteboard')
      click_on 'Log Out'
      expect(page).to have_content('You have been logged out.')
    end
  end
end
