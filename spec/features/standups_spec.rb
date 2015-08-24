require 'rails_helper'

describe "standups" do
  before do
    login
    visit '/'
    FactoryGirl.create(:standup)

    find('h2').should have_content 'CHOOSE A STANDUP'
    click_link('New Standup')

    fill_in 'standup_title', with: "London"
    fill_in 'standup_subject_prefix', with: "[Standup][ENG]"
    select 'Mountain Time (US & Canada)', from: "standup_time_zone_name"
    fill_in 'standup_to_address', with: "all@pivotallabs.com"
    fill_in 'standup_closing_message', with: "Woohoo"
    fill_in 'standup_start_time_string', with: '10:00am'
    fill_in 'standup_image_urls', with: 'http://example.com/bar.png'
    click_button 'Create Standup'

    click_link('All Standups')
    page.should have_content 'LONDON'
    click_link('London')
  end

  it "creates new standups", js: true do
    current_page = current_url
    current_page.should match(/http:\/\/127\.0\.0\.1:\d*\/standups\/\d*/)
    find('div.navbar-fixed-top').should have_content 'London Whiteboard'

    page.find('a.btn.btn-navbar').click if page.has_css?('.btn.btn-navbar')
    page.find('a.posts', text: 'Posts').click
    page.should have_content 'Current Post'
    click_link('Current Post')
    page.should have_content 'London Whiteboard'
    current_page.should match(/http:\/\/127\.0\.0\.1:\d*\/standups\/\d*/)

    click_on_preferences(page)
    page.should have_css('input[value="London"]')
    page.should have_css('input[value="[Standup][ENG]"]')
    page.should have_css('input[value="all@pivotallabs.com"]')
    page.should have_css('input[value="Woohoo"]')
    page.should have_css('option[value="Mountain Time (US & Canada)"][selected]')
    page.should have_css('input[value="10:00am"]')
  end

  it "allows you to delete existing standups", js: true do
    click_on_preferences(page)
    click_on 'Delete Standup'

    current_url.should match(/http:\/\/127\.0\.0\.1:\d*\/standups$/)
    page.should_not have_content 'London Whiteboard'
  end

  it 'takes you to the last standup you viewed' do
    visit '/'
    click_link('London')

    visit '/'
    expect(page).to have_content('London Whiteboard')
  end
end
