//
//  TweetsServiceProtocol.swift
//  TwitDemo
//
//  Created by Inaldo Ramos Ribeiro on 04/08/2020.
//  Copyright © 2020 Inaldo Ramos Ribeiro. All rights reserved.
//

import Foundation


/// Service in charge of fetching the locations of the current LAT/LON from the API server.
protocol TweetsServiceProtocol {

    // MARK: Properties

    /// Object in charge of requesting the locations from the server.
    var provider: TweetsAPI.Provider { get set }

    // MARK: Imperatives

    /// Fetch the locations from the API.
    /// - Parameters:
    ///     - Northeast: Lat/Lon of Northeast.
    ///     - Southwest: Lat/Lon of Southwest.
    ///     - handler: closure called when the request finishes.
    func updateTweets(accountID: String,
                        andCompletionHandler handler: @escaping (TweetsAPIResponse?, APIError?) -> Void)
}

