# CardSlotsController.rb
# CardSlots
#
# Created by wpc on 2/16/10.
# Copyright 2010 __MyCompanyName__. All rights reserved.

class CardSlotsController < NSWindowController
	attr_accessor :window, :menu
	
	def awakeFromNib
		window.opaque = false
		window.alphaValue = 0.85
	end
end
