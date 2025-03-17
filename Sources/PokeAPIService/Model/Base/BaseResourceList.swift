//
//  BaseResourceList.swift
//  PokeAPIService
//
//  Created by Thomas George on 01/03/2025.
//

import Foundation

public struct BaseResourceList: Codable {
    public let urls: [BaseResource]

    public enum CodingKeys: String, CodingKey {
        case urls = "results"
    }
}
