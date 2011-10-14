#
#  HttpClient.rb
#  CardSlots
#
#  Created by Thought Worker on 10/13/11.
#  Copyright 2011 ThoughtWorks. All rights reserved.
#


class HttpClient
    def initialize(delegate)
        @delegate = delegate
    end
    
    def get(url, user=nil, pass=nil, &block)
        puts "get #{url}, #{user}, #{pass}"
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
                get(url, userinput, passinput, &block)
            end
            when Net::HTTPSuccess
            yield(res.body)
            else
            res.error!
        end
    end
end