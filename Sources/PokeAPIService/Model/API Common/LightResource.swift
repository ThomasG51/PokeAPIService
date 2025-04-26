//
//  LightResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 02/03/2025.
//

import Foundation

/// Model for API Light Resource
///
public struct LightResource: Codable {
    // MARK: - Public

    public var id: String {
        String(url.split(separator: "/").last ?? "")
    }

    public var name: String {
        _name ?? "no name for this resource"
    }

    public var type: String {
        String(url.split(separator: "/").dropLast().last ?? "")
    }

    // MARK: - Internal

    private let _name: String?
    private let url: String

    enum CodingKeys: String, CodingKey {
        // swiftlint:disable:next identifier_name
        case _name = "name"
        case url
    }
}
