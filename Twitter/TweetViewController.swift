//
//  TweetViewController.swift
//  Twitter
//
//  Created by Rob Hislop on 5/4/15.
//  Copyright (c) 2015 Rob Hislop. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    var tweet: Tweet!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.setImageWithURL(tweet.user?.profileImageUrl)
        nameLabel.text = tweet.user?.screenname
        tweetLabel.text = tweet.text

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
