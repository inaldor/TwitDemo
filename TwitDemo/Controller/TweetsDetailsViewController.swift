//
//  TweetsDetailsViewController.swift
//  TwitDemo
//
//  Created by Inaldo Ramos Ribeiro on 04/08/2020.
//  Copyright © 2020 Inaldo Ramos Ribeiro. All rights reserved.
//

import UIKit

/// The controller showing the timeline of the chosen influencer.
class TweetsDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    
    /// Array containing the tweets of the timeline of the chosen influencer
    var arrayTweets: [Tweets]?
    
    /// Account name of the chosen influencer
    var accountName: String?
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Securing unwrap the array of tweets
        guard let tweets = arrayTweets else { return }
        
        
        /// Checking if the array is not empty
        if tweets.count > 1 {
            
            let tweetUserInfo = tweets[0]
            
            /// Defining the title of navigation bar item
            navigationItem.title = "@" + tweetUserInfo.user.screen_name
            
        }
    }
    
    /// MARK: Table View Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let tweets = arrayTweets else { return 0 }
        
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TweetsDetailsCell

        guard let tweets = arrayTweets else { return cell }
        
        let tweet = tweets[indexPath.row]
        
        cell.tweetTextLabel.text = tweet.text
        cell.createdLabel.text = tweet.created_at
        
        return cell
        
    }
}
