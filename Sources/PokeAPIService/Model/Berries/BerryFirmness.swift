//
//  BerryFirmness.swift
//  PokeAPIService
//
//  Created by Thomas George on 12/04/2025.
//

import Foundation

/// Model for BerryFirmness API Resource
///
struct BerryFirmness: Decodable {
    let id: Int
    let name: String
    let berries: [BaseResource]
    let names: [NameLanguage]
}
