//
//  TwitterClient.swift
//  Twitter
//
//  Created by Rob Hislop on 5/2/15.
//  Copyright (c) 2015 Rob Hislop. All rights reserved.
//

import UIKit

let twitterConsumerKey = "LiF50ev3oRBDgueeEvQpfcN0G"
let twitterConsumerSecret = "98MfonwSSzQKWgP4wE4SPj58xjaY9XqwutgTIawB0Nrt3uPkJM"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
   
}
