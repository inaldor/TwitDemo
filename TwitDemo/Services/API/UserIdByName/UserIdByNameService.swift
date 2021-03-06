//
//  UserIdByNameService.swift
//  TwitDemo
//
//  Created by Inaldo Ramos Ribeiro on 05/08/2020.
//  Copyright © 2020 Inaldo Ramos Ribeiro. All rights reserved.
//

import Foundation
import Moya

struct UserIdByNameService: UserIdByNameServiceProtocol {

    // MARK: Properties

    var provider: MoyaProvider<UserIdByNameAPI>
    
    // MARK: Initializers
    
    init(provider: MoyaProvider<UserIdByNameAPI>) {
        self.provider = provider
    }

    // MARK: Imperatives

    func fetchUserId(accountName: String,
    andCompletionHandler handler: @escaping (UserIdByNameAPIResponse?, APIError?) -> Void) {
        
        let target = UserIdByNameAPI.accountId(accountName: accountName)
            
        provider.request(target) { result in
            switch result {
            case .success(let response):
                guard response.statusCode != 401 else {
                    handler(nil, .requestFailed(statusCode: 401))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let accountIdFetch = try decoder.decode(UserIdByNameAPIResponse.self, from: response.data)
                    
                    handler(accountIdFetch, nil)
                } catch {
                    handler(nil, .parsingFailed)
                }
                
            case .failure(_):
                handler(nil, .connectionProblem)
            }
        }
    }
}
