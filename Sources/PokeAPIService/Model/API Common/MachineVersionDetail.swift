//
//  MachineVersionDetail.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/04/2025.
//

import Foundation

/// Model for MachineVersionDetail API Resource
///
public struct MachineVersionDetail: Decodable {
    public let machine: BaseResource
    public let generation: BaseResource
}
