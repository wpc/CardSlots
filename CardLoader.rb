# CardLoader.rb
# CardSlots
#
# Created by wpc on 2/19/10.
# Copyright 2010 __MyCompanyName__. All rights reserved.

class CardLoader
	def initialize(url)
		@url = url
	end
	
	def	load(&block)
		Thread.new do
			puts "loading #{@url}"
            begin
                yield(load_card)
            rescue => e
                p e
            end
		end
	end
    
    private
    def load_card
        sleep 2
        card = Card.new
        card.name = "User can move the hightlight on droplist via arrow keys"
        card.number = "22"
        card
    end 
end