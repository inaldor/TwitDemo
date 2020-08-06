//
//  TweetsService.swift
//  TwitDemo
//
//  Created by Inaldo Ramos Ribeiro on 04/08/2020.
//  Copyright © 2020 Inaldo Ramos Ribeiro. All rights reserved.
//

import Foundation
import Moya

struct TweetsService: TweetsServiceProtocol {

    // MARK: Properties

    var provider: MoyaProvider<TweetsAPI>
    //var keychain: KeychainStore
    
    // MARK: Initializers
    
    init(provider: MoyaProvider<TweetsAPI>/*, keychain: KeychainStore*/) {
        self.provider = provider
        //self.keychain = keychain
    }
    
    // MARK: Imperatives

    func updateTweets(accountID: String,
    andCompletionHandler handler: @escaping (TweetsAPIResponse?, APIError?) -> Void) {

        let target = TweetsAPI.tweets(accountID: accountID)

        provider.request(target) { result in
            switch result {
            case .success(let response):
                guard response.statusCode != 401 else {
                    handler(nil, .requestFailed(statusCode: 401))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let tweetsFetch = try decoder.decode(TweetsAPIResponse.self, from: response.data)

                    handler(tweetsFetch, nil)
                } catch {
                    handler(nil, .parsingFailed)
                }

            case .failure(_):
                handler(nil, .connectionProblem)
            }
        }
    }
}
