//
//  UserIdByNameServiceProtocol.swift
//  TwitDemo
//
//  Created by Inaldo Ramos Ribeiro on 05/08/2020.
//  Copyright © 2020 Inaldo Ramos Ribeiro. All rights reserved.
//


import Foundation


/// Service in charge of fetching the User ID of the username from the API server.
protocol UserIdByNameServiceProtocol {

    // MARK: Properties

    /// Object in charge of requesting the userID from the server.
    var provider: UserIdByNameAPI.Provider { get set }

    // MARK: Imperatives

    /// Fetch the userID from the API.
    /// - Parameters:
    ///     - accountName: Screem name of the account.
    ///     - handler: closure called when the request finishes.
    func fetchUserId(accountName: String,
                        andCompletionHandler handler: @escaping (UserIdByNameAPIResponse?, APIError?) -> Void)
}

