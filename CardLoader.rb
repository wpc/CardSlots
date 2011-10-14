# CardLoader.rb
# CardSlots
#
# Created by wpc on 2/19/10.
# Copyright 2010 __MyCompanyName__. All rights reserved.

class CardLoader
    def initialize(http_client)
        @http_client = http_client
    end
    
	def	load(url, &block)
        @http_client.get(to_api_card_url(url)) do |body|
            xml = Hash.from_xml(body)
            card = Card.new
            card.name = xml["card"]["name"]
            card.number = xml["card"]["number"]
            yield(card)
        end
	end
    
    private

    def to_api_card_url(html_url)
        url = URI.parse(html_url)
        url.path = "/api/v2#{url.path}.xml"
        url.to_s
    end
end