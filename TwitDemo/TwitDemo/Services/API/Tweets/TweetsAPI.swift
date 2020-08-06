//
//  TweetsAPI.swift
//  TwitDemo
//
//  Created by Inaldo Ramos Ribeiro on 04/08/2020.
//  Copyright © 2020 Inaldo Ramos Ribeiro. All rights reserved.
//

import Foundation
import Moya

/// The description of the locations API.
enum TweetsAPI {
    case tweets(accountID: String)
}

extension TweetsAPI: TargetType {

    // MARK: Types

    typealias Provider = MoyaProvider<TweetsAPI>

    // MARK: TargetType implementation.

    var path: String {
        switch self {
        case .tweets(let accountId):
            return "1.1/statuses/user_timeline.json?user_id=2244994945"
        }
    }

    //\(accountId)
    
    var method: Moya.Method {
        switch self {
        case .tweets:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .tweets:
            return .requestPlain
        }

    }

    var sampleData: Data {
        switch self {
        case .tweets:
            // TODO:
            return "Test".data(using: String.Encoding.utf8)!
        }
    }

    var headers: [String : String]? {
        return API.basicHeaders
    }
}
