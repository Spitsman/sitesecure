require 'httpclient'
require 'json'

class Client

  def initialize(api_url, api_version)
    @api_url = api_url
    @api_version = api_version
  end

  def request(http_method:, endpoint:, resource: nil, params: nil)
    path = build_url(endpoint, resource)
    query = build_query(params)

    case http_method
    when :get
      get(path, query)
    end
  end

  private

  def get(path, query = '')
    request_str = URI::HTTPS.build(host: @api_url, path: path, query: query).to_s
    response = http_client.get(request_str)

    raise StandardError, "HTTP status: #{response.status}, body: #{response.body}" unless response.status == 200

    JSON.parse(response.body)
  end

  def http_client
    @http_client ||= HTTPClient.new
  end

  def build_url(endpoint, resource)
    '/' + [@api_version, endpoint, resource].compact.join('/')
  end

  def build_query(query)
    return if query.nil?

    query.map { |k, v| "#{k}=#{v.join(',')}" }.join('&')
  end
end
