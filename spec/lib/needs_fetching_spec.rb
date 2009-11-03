require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'fakeweb'

describe OpenURI::Meta do
  
  before do
    @url = "http://example.com/test1"
  end
  
  it "will return true if no past data provided" do
    FakeWeb.register_uri(:get, @url, :body => "Hello World!")
    @result = open(@url)
    @result.needs_fetching?(nil, nil).should be_true
  end
  
  it "will return true if expires has passed" do
    FakeWeb.register_uri(:get, @url, :body => "Hello World!", :expires => 'Thu, 01 Dec 1994 16:00:00 GMT')
    @result = open(@url)
    @result.needs_fetching?(nil, nil).should be_true
  end
  
  it "will return true if last modified is newer than last fetched" do
     FakeWeb.register_uri(:get, @url, :body => "Hello World!", :last_modified => 'Thu, 01 Dec 2995 16:00:00 GMT')
      @result = open(@url)
      @result.needs_fetching?(Date.parse('Thu, 01 Dec 1994 13:00:00 GMT'), nil).should be_true
  end
  
  it "will return true if last modified is not available" do
    FakeWeb.register_uri(:get, @url, :body => "Hello World!")
    @result = open(@url)
    @result.needs_fetching?(Date.parse('Thu, 01 Dec 1994 13:00:00 GMT'), 'blablabla').should be_true
  end
  
  it "will return false if etag matches" do
    FakeWeb.register_uri(:get, @url, :body => "Hello World!", :etag => 'blablabla')
    @result = open(@url)
    @result.needs_fetching?(Date.parse('Thu, 01 Dec 1994 13:00:00 GMT'), 'blablabla').should be_false
  end
  
  it "will return false if last modified is older than last fetched" do
    FakeWeb.register_uri(:get, @url, :body => "Hello World!", :last_modified => 'Thu, 01 Dec 1995 16:00:00 GMT')
    @result = open(@url)
    @result.needs_fetching?(Date.parse('Thu, 01 Dec 1996 13:00:00 GMT'), nil).should be_false
  end

  it "will return false if expires has not passed" do
    FakeWeb.register_uri(:get, @url, :body => "Hello World!", :expires => 'Thu, 01 Dec 2994 16:00:00 GMT')
    @result = open(@url)
    @result.needs_fetching?(Date.parse('Thu, 01 Dec 1994 13:00:00 GMT'), nil).should be_false
  end
  
end