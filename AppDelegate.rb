#
#  AppDelegate.rb
#  CardSlots
#
#  Created by Thought Worker on 10/13/11.
#  Copyright 2011 ThoughtWorks. All rights reserved.
#


class AppDelegate
    attr_accessor :window
    
    def applicationDidFinishLaunching(a_notification)
        window.opaque = false
		window.alphaValue = 0.65
        window.level = NSFloatingWindowLevel
    end
end