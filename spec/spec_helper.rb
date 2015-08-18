RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.before(:all, type: :feature) do
    current_session = Capybara.current_session
    current_session.driver.resize_window(2000, 2000)
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:each, :type => :feature) do |example|
    if example.exception
      artifact = save_page
      puts "\"#{example.description}\" failed. Page saved to #{artifact}"
    end
  end

  config.around(:each, inaccessible: true) do |example|
    Capybara::Accessible.skip_audit { example.run }
  end

  config.render_views

  config.include FactoryGirl::Syntax::Methods
  config.include MockAuth, :type => :feature

  def click_on_preferences(page)
    page.find('a.btn.btn-navbar').click if page.has_css?('.btn.btn-navbar')
    click_on 'Preferences'
  end

  def blur(page)
    page.find(:css, 'body').click
  end
end
