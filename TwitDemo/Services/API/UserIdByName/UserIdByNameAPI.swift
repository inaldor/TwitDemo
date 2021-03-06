//
//  UserIdByNameAPI.swift
//  TwitDemo
//
//  Created by Inaldo Ramos Ribeiro on 05/08/2020.
//  Copyright © 2020 Inaldo Ramos Ribeiro. All rights reserved.
//

import Foundation
import Moya

/// The description of the UserIdByName API.
enum UserIdByNameAPI {
    case accountId(accountName: String)
}

extension UserIdByNameAPI: TargetType {

    // MARK: Types

    typealias Provider = MoyaProvider<UserIdByNameAPI>

    // MARK: TargetType implementation.

    var path: String {
        switch self {
        case .accountId(let accountName):
            return "/labs/2/users/by/username/\(accountName)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .accountId:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .accountId:
            return .requestPlain
        }
    
    }

    var sampleData: Data {
        switch self {
        case .accountId:
            return "Test".data(using: String.Encoding.utf8)!
        }
    }

    var headers: [String : String]? {
        return API.basicHeaders
    }
}
