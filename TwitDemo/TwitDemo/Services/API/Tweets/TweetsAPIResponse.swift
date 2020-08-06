//
//  TweetsAPIResponse.swift
//  TwitDemo
//
//  Created by Inaldo Ramos Ribeiro on 04/08/2020.
//  Copyright © 2020 Inaldo Ramos Ribeiro. All rights reserved.
//

import Foundation

typealias TweetsAPIResponse = [Tweets]

/// The codable struct representing the response from the /loadmappointsboxed API endpoint.
struct Tweets: Codable {
    
    // MARK: Properties

    let created_at: String
    let text: String
    
    // MARK: Initializers
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let createDecode = try values.decode(String.self, forKey: .created_at)
        let textDecode = try values.decode(String.self, forKey: .text)
        
        created_at = createDecode
        text = textDecode
    }

    
    // MARK: Coding Keys

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case text = "text"
    }
}
