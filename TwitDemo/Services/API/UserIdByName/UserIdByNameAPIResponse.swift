//
//  UserIdByNameAPIResponse.swift
//  TwitDemo
//
//  Created by Inaldo Ramos Ribeiro on 05/08/2020.
//  Copyright © 2020 Inaldo Ramos Ribeiro. All rights reserved.
//

import Foundation

/// The codable struct representing the response from the userIdByName API endpoint.
struct UserIdByNameAPIResponse: Codable {
    
    // MARK: Properties

    let dataUser: DataUser
    
    // MARK: Coding Keys

    enum CodingKeys: String, CodingKey {
        case dataUser = "data"
    }
}
    
// MARK: Internal Types

extension UserIdByNameAPIResponse {

    struct DataUser: Codable {

        // MARK: Properties

        let id: String
        let name: String
        let username: String


        // MARK: Initializers

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)

            if let idDecode = try values.decodeIfPresent(String.self, forKey: .id) {
                
                id = idDecode
                
            } else {
                
                id = ""
                
            }
            
            if let nameDecode = try values.decodeIfPresent(String.self, forKey: .name) {
                
                name = nameDecode
                
            } else {
                
                name = ""
                
            }
            
            if let usernameDecode = try values.decodeIfPresent(String.self, forKey: .username) {
                
                username = usernameDecode
                
            } else {
                
                username = ""
                
            }
        }

        // MARK: Coding Keys

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case username = "username"
        }
    }
}
