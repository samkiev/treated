require 'page-object'
require 'rspec'
require 'selenium-webdriver'
require 'yaml'


RSpec.configure do |config|
  config.include PageObject::PageFactory

  config.before :all do
    config.include PageObject::PageFactory
    @data=YAML::load(File.read("data/data.yaml"));
    @browser = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @browser.manage().window().maximize()
    PageObject.default_page_wait = 20
    PageObject.default_element_wait = 20

  end

  config.after :all  do
    @browser.close
  end

end
  shared_examples 'current title include' do |message|
    it "with text #{message}" do
      # expected_title message
      # @current_page.has_expected_title?
      expect(@current_page.title).to include message
    end
  end

  shared_examples 'current page include' do |message|
    it "text #{message}" do
      expect(@current_page.text).to include message
    end
  end
