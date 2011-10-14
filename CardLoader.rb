# CardLoader.rb
# CardSlots
#
# Created by wpc on 2/19/10.
# Copyright 2010 __MyCompanyName__. All rights reserved.

class CardLoader
    def initialize(delegate)
        @delegate = delegate
    end
    
	def	load(url, &block)
		Thread.new do
			puts "loading #{@url}"
            begin
                yield(load_card(url))
            rescue => e
                p e
            end
		end
	end
    
    private
    def load_card(url)
        fetch(to_api_card_url(url)) do |body|
            xml = Hash.from_xml(body)
            card = Card.new
            card.name = xml["card"]["name"]
            card.number = xml["card"]["number"]
            card
        end
    end

    def to_api_card_url(html_url)
        url = URI.parse(html_url)
        url.path = "/api/v2#{url.path}.xml"
        url.to_s
    end
    
    def fetch(url, user=nil, pass=nil, &block)
        uri = URI.parse(url)
        
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == 'https'
        
        res = http.start do |http|
            req = Net::HTTP::Get.new(uri.path)
            req.basic_auth user, pass if user
            http.request(req)
        end
        
        case res
        when Net::HTTPUnauthorized
            @delegate.ask_user_and_pass(uri.host) do |userinput, passinput|
                fetch(url, userinput, passinput, &block)
            end
        when Net::HTTPSuccess
            yield(res.body)
        else
            res.error!
        end
    end
end