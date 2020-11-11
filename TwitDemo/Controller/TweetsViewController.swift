//
//  TweetsViewController.swift
//  TwitDemo
//
//  Created by Inaldo Ramos Ribeiro on 03/08/2020.
//  Copyright © 2020 Inaldo Ramos Ribeiro. All rights reserved.
//

import UIKit

/// The initial controller of the app, for when the user enter the name of his favorite influencer.
class TweetsViewController: UIViewController {
    
    // MARK: Properties

    /// The service used to get the ID of the chosen influencer.
    var userIdByNameService: UserIdByNameServiceProtocol?
    
    /// The service used to get the list of tweets of the chosen influencer.
    var tweetsService: TweetsServiceProtocol?
    
    
    /// Outlets of the objects in the view
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameField: UITextField!
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Setting the Activity Indicator to hide when stopped
        activityIndicator.hidesWhenStopped = true
        
        /// Setting the tap to hide the keyboard when not clicking an object
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    // MARK: Actions

    /// Action to be performed when clicking on GO! button
    @IBAction func goButton(_ sender: UIButton) {
        
        /// Animating the activity indicator
        activityIndicator.startAnimating()
        
        /// Fetching UserId and then fetching the timeline of that chosen user
        fetchUserId() { userID in
            self.fetchTweets(accountID: userID)
        }
        
}

    /// Fetching the userID from the name entered by user.
    private func fetchUserId(completion: @escaping ((_ userID: String) -> Void)) {
        
        /// Service in charge of fetch the UserID
        self.userIdByNameService = UserIdByNameService(provider: UserIdByNameAPI.Provider())
        
        guard let userIdByNameService = userIdByNameService else { return }
        
        /// Fetching the String entered in the nameField
        guard var accountName = nameField.text else { return }
        
        /// Removing the first character of the String: @, if exist
        if accountName.first == "@" {
            accountName = String(accountName.dropFirst())
        }
        
        /// Removing the last character of the String: " ", if exist
        if accountName.last == " " {
            accountName = String(accountName.dropLast())
        }
         
        /// Fetching the UserId using the name entered in the textField
        userIdByNameService.fetchUserId(accountName: accountName) { (response, error) in
            
            DispatchQueue.main.async {
                
                /// Checking if we have a response
                if let response = response {
                    
                    let accountUserId = response.dataUser.id
                    
                    print("Success")
                    
                    /// Associating the accountUserID fetched to completion
                    completion(accountUserId)
                    
                } else {
                    print(error)
                    
                    /// Stopping the animation of the Activity Indicator
                    self.activityIndicator.stopAnimating()
                    
                    /// Triggering the alert of Error
                    self.triggerAlert()
                    
                }
            }
        }

    }
    
    /// Function to trigger the Error Alert
    private func triggerAlert() {
        
        let alert = UIAlertController(title: "Try Again", message: "We can't find an influencer with this name, please try again...", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
    
        self.present(alert, animated: true, completion: nil)
        
    }
    
    /// Function to fetch the timeline of the chosen influencer
    private func fetchTweets(accountID: String) {
       
       /// Service in charge of fetch the last tweets of the chosen influencer
       self.tweetsService = TweetsService(provider: TweetsAPI.Provider())
       
       guard let tweetsService = tweetsService else { return }
       
       tweetsService.updateTweets(accountID: accountID) { (response, error) in
           

           DispatchQueue.main.async {
               
            /// Checking if we have a response
                if let response = response {
                
                print("Success")
                
                /// Stopping the animation of the Activity Indicator
                self.activityIndicator.stopAnimating()
                
                /// Performing a segue to the next view controller - A TweetDetailsViewController
                self.performSegue(withIdentifier: "segueToTweetDetailsViewController", sender: response)
                   
               } else {

                    /// Stopping the animation of the Activity Indicator
                    self.activityIndicator.stopAnimating()
                                    
                    /// Triggering the alert of Error
                    self.triggerAlert()
                
                }
           }
       }
    }
        
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueToTweetDetailsViewController" {
            if let tweetDetailsViewController = segue.destination as? TweetsDetailsViewController, let tweets = sender {
                tweetDetailsViewController.arrayTweets = tweets as! [TwitDemo.Tweets]}
        }
    }
}
