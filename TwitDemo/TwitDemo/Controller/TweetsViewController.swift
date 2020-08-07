//
//  TweetsViewController.swift
//  TwitDemo
//
//  Created by Inaldo Ramos Ribeiro on 03/08/2020.
//  Copyright © 2020 Inaldo Ramos Ribeiro. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    var userIdByNameService: UserIdByNameServiceProtocol?
    var tweetsService: TweetsServiceProtocol?
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
    }

    @IBAction func goButton(_ sender: UIButton) {
        
        activityIndicator.startAnimating()
        
        self.userIdByNameService = UserIdByNameService(provider: UserIdByNameAPI.Provider())
        
        guard let userIdByNameService = userIdByNameService else { return }
        guard let accountName = nameField.text else { return }
        
        userIdByNameService.fetchUserId(accountName: accountName) { (response, error) in
            
            print(response)
            
            DispatchQueue.main.async {
                
                if let response = response {
                    
                    self.activityIndicator.stopAnimating()
                    
                    let accountUser = response.dataUser.id
                    
                    self.performSegue(withIdentifier: "segueToTweetDetailsViewController", sender: accountUser)
                    
                    print("Success")
                    
                } else {
                    print(error)
                    assertionFailure("If we don't have a response, the error should be set here.")
                }
            }
        }
        
        
    }
    
//
//    private func fetchUserId() {
//
//        self.userIdByNameService = UserIdByNameService(provider: UserIdByNameAPI.Provider())
//
//        guard let userIdByNameService = userIdByNameService else { return }
//
//        userIdByNameService.fetchUserId(accountName: "TwitterDev") { (response, error) in
//
//
//            print(response)
//
//            DispatchQueue.main.async {
//
//                if let response = response {
//
//                    print("Success")
//
//                } else {
//                    print(error)
//                    assertionFailure("If we don't have a response, the error should be set here.")
//                }
//            }
//        }
//    }
    
    
       private func fetchTweets() {
           
           self.tweetsService = TweetsService(provider: TweetsAPI.Provider())
           
           guard let tweetsService = tweetsService else { return }
           
           tweetsService.updateTweets(accountID: "2244994945") { (response, error) in
               
               
               print(response)
               print(error.debugDescription)
               print(error?.localizedDescription)
               print(error?.message)
               
               DispatchQueue.main.async {
                   
                   if let response = response {
                       
                       print("Success")
                       
                   } else {
                       print(error)
                       assertionFailure("If we don't have a response, the error should be set here.")
                   }
               }
           }
       }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueToTweetDetailsViewController" {
            if let tweetDetailsViewController = segue.destination as? TweetsDetailsViewController, let id = sender {
                tweetDetailsViewController.accountId = id as? String ?? ""
            }
        }
    }
}
