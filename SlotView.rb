# SlotView.rb
# CardSlots
#
# Created by wpc on 2/16/10.
# Copyright 2010 __MyCompanyName__. All rights reserved.

class SlotView < NSView
	attr_accessor :spinner, :state

	def	initWithFrame(frameRect)
		super(frameRect)
		registerForDraggedTypes [NSURLPboardType]
		self.state = :wait
		self
	end
	
	def	drawRect(rect)
		return if state == :loaded
		drawBackground(NSColor.whiteColor)
		printHint if state == :wait
	end
	
	def	draggingEntered(sender)
		# todo: when url not end with /cards/\d+ return NSDragOperationNone
		return NSDragOperationCopy
	end
	
	def	performDragOperation(sender)
		cardLoader = cardLoaderFromPasteboard(sender.draggingPasteboard)
		
        self.state = :loading
        spinner.hidden = false
        spinner.startAnimation(self)
        spinner.display
        setNeedsDisplay(true)
            
		cardLoader.load do |card|
            puts "card = #{card}"
			spinner.hidden = true
			spinner.stopAnimation(self)
			cardview = CardView.alloc.initWithFrame(bounds)
			cardview.card = card
			addSubview(cardview)
			self.state = :loaded
			setNeedsDisplay(true)
        end
	rescue  => e
		puts "#{e.message}"
		puts e.backtrace
	end
	
	private
	
	def	cardLoaderFromPasteboard(pasteboard)
		CardLoader.new(NSURL.URLFromPasteboard(pasteboard).absoluteString)
	end
	
	def	printHint
		"Drop a card here".drawAtPoint(hintPosition, withAttributes: {
			 NSForegroundColorAttributeName => NSColor.blackColor,
			 NSFontAttributeName => NSFont.boldSystemFontOfSize(12.0)
		})
	end
	
	def	hintPosition
		NSPoint.new(26, bounds.size.height / 2.0)
	end
	
	def	drawBackground(color)
		color.set
		NSRectFill(bounds)
	end	
end