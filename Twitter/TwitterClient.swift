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
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath(
            "oauth/request_token",
            method: "GET",
            callbackURL: NSURL(string: "twitterbyrob://oauth"),
            scope: nil,
            success: { (requestToken: BDBOAuth1Credential!) -> Void in
                println("Request token fetch success")
                var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authURL!)
                
            },
            failure: { (error: NSError!) -> Void in
                println("Failed to fetch request token")
                self.loginCompletion?(user: nil, error: error)
            }
        )
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token",
            method: "POST",
            requestToken: BDBOAuth1Credential(queryString: url.query),
            success: { (accessToken: BDBOAuth1Credential!) -> Void in
                println("Got the access token.")
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                
                
                TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json",
                    parameters: nil,
                    success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                        //println("user: \(response)")
                        var user = User(dictionary: response as! NSDictionary)
                        println("user: \(user.name)")
                        self.loginCompletion?(user: user, error: nil)
                    }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                        println("Error retrieving current user")
                        self.loginCompletion?(user: nil, error: error)
                })
                
                TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json",
                    parameters: nil,
                    success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                        var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                        for tweet in tweets {
                            println("tweet: \(tweet.text)")
                        }
                        
                    }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                        println("Error retrieving timeline")
                })
                
            })
            {(error: NSError!) -> Void in
                println("Failed to get access token.")
                self.loginCompletion?(user: nil, error: error)
        }

    }
   
}
