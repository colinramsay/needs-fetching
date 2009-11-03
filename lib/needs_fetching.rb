require 'ruby-debug'
require 'open-uri'

module OpenURI::Meta
  def needs_fetching?(last_retrieved, last_etag)
    
    expires = self.meta['expires']
    etag = self.meta['etag']
    last_modified = self.meta['last-modified']

    if(last_modified == nil and etag == nil and expires == nil)
      return true
    end

    if(etag && etag == last_etag)
      return false
    end

    if(expires and Date.parse(expires) >= Date.today)
      return false
    end
    
    if(last_modified and Date.parse(last_modified) < last_retrieved)
      return false
    end
    
    return true
  end
end