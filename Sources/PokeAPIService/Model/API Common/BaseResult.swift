//
//  BaseResourceList.swift
//  PokeAPIService
//
//  Created by Thomas George on 01/03/2025.
//

import Foundation

public struct BaseResult: Codable {
    public let resources: [BaseResource]

    public enum CodingKeys: String, CodingKey {
        case resources = "results"
    }
}
