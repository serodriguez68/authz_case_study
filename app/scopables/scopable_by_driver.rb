module ScopableByDriver
  extend Authz::Scopables::Base
  def self.available_keywords
    %w[Mine All]
  end

  def self.resolve_keyword(keyword, requester)
    if keyword == 'Mine'
      [requester.driver.id]
    end
  end
end