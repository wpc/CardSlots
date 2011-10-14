# CardView.rb
# CardSlots
#
# Created by wpc on 2/18/10.
# Copyright 2010 __MyCompanyName__. All rights reserved.
class CardView < NSView
	
	def	initWithFrame(rect)
		super
		@webView = WebView.alloc.initWithFrame(rect)
		self.addSubview(@webView)
		self
	end
	
	def	card=(card)
        @webView.mainFrame.loadHTMLString("<strong>##{card.number}</strong> #{card.name}",
                                          baseURL: nil)
	end
end
