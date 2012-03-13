*This library is no longer in active development. For a trimmed version, check
out [Vacuum] [vacuum].*

***

# Amazon Product

Amazon Product is a [Nokogiri][1]-backed Ruby wrapper to the [Amazon
Product Advertising API] [2].

[![travis](https://secure.travis-ci.org/hakanensari/amazon_product.png)](http://travis-ci.org/hakanensari/amazon_product)

## Installation

Add to your Gemfile.

    gem 'amazon_product'

## Usage

Set up a request.

    require "amazon_product"

    req = AmazonProduct["us"]

    req.configure do |c|
      c.key    = AMAZON_KEY
      c.secret = AMAZON_SECRET
      c.tag    = AMAZON_ASSOCIATE_TAG
    end

Search for something.

    req << { :operation    => 'ItemSearch',
             :search_index => 'All',
             :keywords     => 'George Orwell' }
    res = req.get

Or use a shorthand.

    res = req.search('George Orwell')

Customise your request.

    res = req.search('Books', :response_group => %w{ItemAttributes Images},
                              :power          => 'George Orwell'

For a reference of available methods and syntax, [read here] [3].

Consume the entire response.

    res.to_hash

Quickly drop down to a particular node.

    res['Item']

## Adapters

Amazon Product defaults to the Net::HTTP library but can be configured
to use Curb or EM-HTTP-Request.

[1]: http://nokogiri.org/
[2]: https://affiliate-program.amazon.co.uk/gp/advertising/api/detail/main.html
[3]: https://github.com/hakanensari/amazon_product/blob/master/lib/amazon_product/operations.rb
[vacuum]: https://github.com/hakanensari/vacuum
