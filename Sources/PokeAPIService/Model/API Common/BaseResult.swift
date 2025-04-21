//
//  BaseResult.swift
//  PokeAPIService
//
//  Created by Thomas George on 01/03/2025.
//

import Foundation

struct BaseResult: Codable {
    let resources: [BaseResource]

    enum CodingKeys: String, CodingKey {
        case resources = "results"
    }
}
