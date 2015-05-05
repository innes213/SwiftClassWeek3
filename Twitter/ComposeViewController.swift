//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Rob Hislop on 5/3/15.
//  Copyright (c) 2015 Rob Hislop. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBAction func onSend(sender: AnyObject) {
        TwitterClient.sharedInstance.postUpdate(
            updateTextView.text, completion: { (error: NSError?) -> () in
                if error != nil {
                    var alert = UIAlertView()
                    alert.message = "Failed to post update! Error: \(error!.description)"
                    alert.show()
                } else {
                    println("Update successful!")
                    self.performSegueWithIdentifier("returnHome", sender: self)
                }
        })
        
    }
    @IBOutlet weak var updateTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTextView.clearsOnInsertion = true

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
