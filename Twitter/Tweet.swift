//
//  Tweet.swift
//  Twitter
//
//  Created by Rob Hislop on 5/2/15.
//  Copyright (c) 2015 Rob Hislop. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    var text: String?
    var screenName: String?
    var name: String?
    var profileImageUrl: NSURL?
    var createdAtString: String?
    var createdAt: NSDate?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        //formatter.dateFormat = "d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        formatter.dateFormat = "EEE h:mm:ss"
        createdAtString = formatter.stringFromDate(createdAt!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
    
}
