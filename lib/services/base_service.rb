require_relative '../client'

class BaseService
  attr_accessor :client

  def initialize(api_url:, api_version: 'v1')
    @client = Client.new(api_url, api_version)
  end
end