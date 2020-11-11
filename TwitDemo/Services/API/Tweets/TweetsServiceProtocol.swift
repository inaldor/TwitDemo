//
//  TweetsServiceProtocol.swift
//  TwitDemo
//
//  Created by Inaldo Ramos Ribeiro on 04/08/2020.
//  Copyright © 2020 Inaldo Ramos Ribeiro. All rights reserved.
//

import Foundation

/// Service in charge of fetching the tweets of the choosen user from the API server.
protocol TweetsServiceProtocol {

    // MARK: Properties

    /// Object in charge of requesting the tweets from the server.
    var provider: TweetsAPI.Provider { get set }

    // MARK: Imperatives

    /// Fetch the tweets from the API.
    /// - Parameters:
    ///     - AccountId: Id Account of the user.
    ///     - handler: closure called when the request finishes.
    func updateTweets(accountID: String,
                        andCompletionHandler handler: @escaping (TweetsAPIResponse?, APIError?) -> Void)
}

