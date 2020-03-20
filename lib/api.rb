require_relative 'services/bitfinex'

class Api
  attr_reader :service

  def initialize(service_name)
    @service = case service_name
               when 'bitfinex'
                 Bitfinex.new
               else
                 raise NotImplementedError, 'Service not implemented'
               end
  end

  def method_missing(name, *args, &block)
    return super unless service.respond_to? name

    service.public_send(name, *args)
  end

  def respond_to_missing?(name, *args)
    service.respond_to?(name) || super
  end
end
