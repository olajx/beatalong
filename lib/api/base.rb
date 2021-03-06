require 'active_support/concern'
require 'httparty'
require 'provider_entity'
require 'provider_playlist'

module Api
  module Base
    extend ActiveSupport::Concern

    included do
      include HTTParty
      format :json
      attr_reader :country_code
    end

    def initialize(country_code = 'us')
      @country_code = country_code
    end

    def clean_api_query_string(query)
      # http://rubular.com/r/mCu0wXlPC7
      query.gsub(/
        (feat(uring|\.)?.*)|
        (\(|\))|
        (-\ EP)|
        (-\ Single)
      /xi, "").strip
    end

    def provider_name
      self.class.to_s.split('::').last
    end
  end
end
