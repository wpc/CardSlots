# CardView.rb
# CardSlots
#
# Created by wpc on 2/18/10.
# Copyright 2010 __MyCompanyName__. All rights reserved.
class CardView < NSView
	
	def	initWithFrame(rect)
		super
		@textView = NSTextView.alloc.initWithFrame(rect)
		@textView.setBackgroundColor(NSColor.blackColor)
		@textView.setTextColor(NSColor.greenColor)
		@textView.setEditable(false)
		@textView.setUsesFontPanel(false)
		self.addSubview(@textView)
		self
	end
	
	def	card=(card)
		@textView.setString("##{card.number}  #{card.name}")
	end
end
