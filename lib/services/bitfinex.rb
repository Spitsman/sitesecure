require_relative 'base_service'

class Bitfinex < BaseService
  API_URL = 'api-pub.bitfinex.com'
  API_VERSION = 'v2'

  def initialize
    super(api_url: API_URL, api_version: API_VERSION)
  end

  def tickers(symbols = [])
    client.request(http_method: :get, endpoint: 'tickers', params: {symbols: symbols})
  end

  def ticker(ticker_name)
    client.request(http_method: :get, endpoint: 'ticker', resource: ticker_name)
  end
end
