//
//  APIDescription.swift
//  TwitDemo
//
//  Created by Inaldo Ramos Ribeiro on 04/08/2020.
//  Copyright © 2020 Inaldo Ramos Ribeiro. All rights reserved.
//

import Foundation
import Moya

/// The enum describing the API main properties.
enum API {

    // MARK: Properties

    /// The api token parameter value used in the network requests.
    static var token: String = {
        
        return "AAAAAAAAAAAAAAAAAAAAAHFEGgEAAAAATU52%2FY4RD%2FH7e91aYdhg9nIqf7g%3Due0jDVnWp96O53VOPEeusGldgwNYKuj1CUwN9n1exuVDWCYA6m"
    }()
    
    /// The basic headers to be sent for every request.
    static var basicHeaders = [
        "Content-Type": "application/json",
        "Accept": "*/*", "Authorization": "Bearer \(API.token)"
    ]
}

extension TargetType {

    // MARK: Default Properties

    var baseURL: URL { return URL(string: "https://api.twitter.com")! }

    /// Those are the default headers to be sent with all requests.
    var headers: [String : String]? {
        return API.basicHeaders
    }
}

/// The basic networking errors of the app.
enum APIError: Error {
    case connectionProblem
    case requestFailed(statusCode: Int)
    case parsingFailed

    // MARK: Properties

    /// The default message associated to the error.
    var message: String {
        var message: String!

        switch self {
        case .connectionProblem:
            message = NSLocalizedString(
                "There's a problem with your internet connection, please, fix it and try again.",
                comment: "Message displayed when the device can't reach the internet."
            )
        case .requestFailed(let statusCode):
            let translationComment = "Message displayed when the server responds with an error."

            if statusCode == 401 {
                message = NSLocalizedString(
                    "You don't have the necessary permissions to access this resource.",
                    comment: translationComment
                )
            } else {
                message = NSLocalizedString(
                    "There was an error while performing the operation. Please, try again later, or contact the support.",
                    comment: translationComment
                )
            }
        case .parsingFailed:
            message = NSLocalizedString(
                "There was an error while performing the network request. Please, contact the support.",
                comment: "Message displayed when the app can't parse the response comming from the server."
            )
        }

        return message
    }
}
