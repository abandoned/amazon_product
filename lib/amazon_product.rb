require 'nokogiri'
require 'eggnog'
require 'openssl'

%w{error locale operations request response}.each do |f|
  require "amazon_product/#{f}"
end

# Amazon Product is a Ruby wrapper to the Amazon Product Advertising API.
module AmazonProduct
  @requests = Hash.new

  # A request.
  #
  # Takes an Amazon locale as argument. This can be +ca+, +cn+, +de+, +fr+,
  # +it+, +jp+, +uk+, or +us+.
  #
  # The library will cache one request per locale.
  def self.[](locale)
    @requests[locale] ||= Request.new(locale)
  end
end
