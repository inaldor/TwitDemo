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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUserId() { userID in
            self.fetchTweets(accountID: userID)
        }
        
//        fetchTweets()
        // Do any additional setup after loading the view.
    }

    
    
    private func fetchUserId(completion: @escaping ((_ userID: String) -> Void)) {
        
        self.userIdByNameService = UserIdByNameService(provider: UserIdByNameAPI.Provider())
        
        guard let userIdByNameService = userIdByNameService else { return }
        
        userIdByNameService.fetchUserId(accountName: "HUBBLE_space") { (response, error) in
            
            
            print(response)
            
            DispatchQueue.main.async {
                
                if let response = response {
                    
                    print("Success")
                    completion(response.dataUser.id)
                    
                } else {
                    print(error)
                    assertionFailure("If we don't have a response, the error should be set here.")
                }
            }
        }
    }

    private func fetchTweets(accountID: String) {

        self.tweetsService = TweetsService(provider: TweetsAPI.Provider())
        
        guard let tweetsService = tweetsService else { return }
        
        tweetsService.updateTweets(accountID: accountID) { (response, error) in
            
            
            print(response)
            print(error.debugDescription)
            print(error?.localizedDescription)
            print(error?.message)
            
            DispatchQueue.main.async {
                
                if let response = response {
                    
                    print("Success")
                    print(response)
                    
                } else {
                    print(error)
                    assertionFailure("If we don't have a response, the error should be set here.")
                }
            }
        }
    }
    
}

