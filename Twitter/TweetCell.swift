//
//  TweetCell.swift
//  Twitter
//
//  Created by Rob Hislop on 5/3/15.
//  Copyright (c) 2015 Rob Hislop. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!

    var tweet: Tweet! {
        didSet {
            profileImage.setImageWithURL(tweet.user?.profileImageUrl)
            nameLabel.text = tweet.user?.screenname
            timestampLabel.text = tweet.createdAtString
            tweetLabel.text = tweet.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImage.layer.cornerRadius = 35
        profileImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
