require 'open-uri'

module OpenURI::Meta
  def needs_fetching?(last_retrieved, last_etag)
    false
  end
end