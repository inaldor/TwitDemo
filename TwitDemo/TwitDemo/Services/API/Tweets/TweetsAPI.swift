//
//  TweetsAPI.swift
//  TwitDemo
//
//  Created by Inaldo Ramos Ribeiro on 04/08/2020.
//  Copyright © 2020 Inaldo Ramos Ribeiro. All rights reserved.
//

import Foundation
import Moya

/// The description of the user_timeline API.
enum TweetsAPI {
    case tweets(accountID: String)
}

extension TweetsAPI: TargetType {

    // MARK: Types

    typealias Provider = MoyaProvider<TweetsAPI>

    // MARK: TargetType implementation.

    var path: String {
        switch self {
        case .tweets:
            return "1.1/statuses/user_timeline.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .tweets:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .tweets(let accountId):
            return .requestParameters(parameters: ["user_id": accountId, "count": 10], encoding: URLEncoding.queryString)
        }
    }

    var sampleData: Data {
        switch self {
        case .tweets:
            return "Test".data(using: String.Encoding.utf8)!
        }
    }

    var headers: [String : String]? {
        return API.basicHeaders
    }
}
