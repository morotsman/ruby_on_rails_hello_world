require 'Selenium-Webdriver'
require 'rspec/autorun'

describe "Hello world app" do
  before(:all) do
    @driver = Selenium::WebDriver.for :firefox
    @driver.navigate.to "http://localhost:3000/"
    @wait =  Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  after(:all) do
    @driver.quit
  end

  it "should display hello world" do
    @driver.find_element(:id,"helloWorldId").text.should  == "Hello world!"
  end
end