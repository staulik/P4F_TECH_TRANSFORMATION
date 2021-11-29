require 'rspec'
require 'capybara/rspec'
require 'pry'
require 'cucumber'
require 'webdrivers'
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'report_builder'
require 'json'
require 'site_prism'
require_relative 'helper.rb'
require 'erb'
require 'json'
require 'faker'



World(PageObjects)

BROWSER = ENV['BROWSER']
DADOS = YAML.load(File.open(File.join(File.dirname(__FILE__) + "/massa/users.yml")))

    Capybara.register_driver:selenium_chrome_headless do |app|
    Capybara::Selenium::Driver.load_selenium
    browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
        
    opts.args << "--headless"
    opts.args << "--disable-gpu"
    opts.args << "--no-sandbox"
    opts.args << "--disable-site-isolation-trials"
    opts.args << "--disable-dev-shm-usage"
  end
       
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: browser_options
  )
          
end

  Capybara.configure do |config|
  if BROWSER.eql?('chrome')
    driver = :selenium_chrome
  elsif BROWSER.eql?('chrome_headless')
    driver = :selenium_chrome_headless
  elsif BROWSER.eql?('firefox')
    driver = :selenium
  elsif BROWSER.eql?('firefox_headless')
    driver = :selenium_headless
  elsif BROWSER.eql?('safari')
    driver = :safari
  elsif BROWSER.eql?('ie')
    driver = :ie
  elsif BROWSER.eql?('edge')
    driver = :edge
  end
  # Setando a configuração do Driver como padrão.
  Capybara.default_driver = driver
  # timeout padrão na execução.
  Capybara.default_max_wait_time = 15
  # Maximizar a tela ao iniciar o teste.
  Capybara.page.driver.browser.manage.window.maximize
  Capybara.page.current_window.resize_to(1366, 768)
end

