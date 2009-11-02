require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'fakeweb'

describe OpenURI::Meta do
  
  before do
    @url = "http://example.com/test1"
    FakeWeb.register_uri(:get, @url, :body => "Hello World!")
    @result = open(@url)
  end
  
  it "will return true if no past data provided" do
    @result.needs_fetching?(nil, nil).should be_false
  end
  
  it "will return true if expires has passed"
  
  it "will return true if last modified is newer than last fetched"
  
  it "will return false if etag matches"
  
  it "will return false if last modified is older than last fetched"
  
  it "will return true if last modified is not provided"
  
end