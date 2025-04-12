//
//  Berry.swift
//  PokeAPIService
//
//  Created by Thomas George on 05/04/2025.
//

import Foundation

public struct Berry: Decodable {
    public let id: Int
    public let name: String
    public let growthTime: Int
    public let maxHarvest: Int
    public let naturalGiftPower: Int
    public let size: Int
    public let smoothness: Int
    public let soilDryness: Int?
    public let firmness: BaseResource
    public let flavors: [BerryFlavorMap]
    public let item: BaseResource
    public let naturalGiftType: BaseResource

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case growthTime = "growth_time"
        case maxHarvest = "max_harvest"
        case naturalGiftPower = "natural_gift_power"
        case size
        case smoothness
        case soilDryness
        case firmness
        case flavors
        case item
        case naturalGiftType = "natural_gift_type"
    }
}

public extension Berry {
    struct BerryFlavorMap: Decodable {
        let potency: Int
        let flavor: BaseResource
    }
}
