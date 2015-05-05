//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Rob Hislop on 5/3/15.
//  Copyright (c) 2015 Rob Hislop. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var refreshControl: UIRefreshControl!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func logoutButton(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        //Autolayout nonsense
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        TwitterClient.sharedInstance.homeTimeWithParams(nil,
            completion: { (tweets, error) -> () in self.tweets = tweets
            self.tableView.reloadData()
        })
        
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        TwitterClient.sharedInstance.homeTimeWithParams(nil,
            completion: { (tweets, error) -> () in self.tweets = tweets
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if let cell = sender as? UITableViewCell {
            let indexPath = tableView.indexPathForCell(cell)!
        
            let tweet = tweets![indexPath.row]
        
            let tweetViewController = segue.destinationViewController as! TweetViewController
        
            tweetViewController.tweet = tweet
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }

}
