//
//  APIResult.swift
//  PokeAPIService
//
//  Created by Thomas George on 01/03/2025.
//

import Foundation

struct APIResult: Codable {
    let resources: [LightResource]

    enum CodingKeys: String, CodingKey {
        case resources = "results"
    }
}
