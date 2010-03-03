# CardLoader.rb
# CardSlots
#
# Created by wpc on 2/19/10.
# Copyright 2010 __MyCompanyName__. All rights reserved.

class CardLoader
	def initialize(url)
		@url = url
	end
	
	def	beforeLoad(&block)
		@beforeLoad = Proc.new(&block)
	end
	
	def	afterLoaded(&block)
		@afterLoaded = Proc.new(&block)
	end
	
	def	load
		@beforeLoad.call if @beforeLoad
		Thread.new do
			puts "loading"
			sleep 2
			@afterLoaded.call(Card.new) if @afterLoaded
		end
	end
end