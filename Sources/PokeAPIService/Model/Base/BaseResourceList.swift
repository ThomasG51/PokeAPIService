//
//  BaseResourceList.swift
//  PokeAPIService
//
//  Created by Thomas George on 01/03/2025.
//

import Foundation

struct BaseResourceList: Codable {
    let urls: [BaseResource]

    enum CodingKeys: String, CodingKey {
        case urls = "results"
    }
}
