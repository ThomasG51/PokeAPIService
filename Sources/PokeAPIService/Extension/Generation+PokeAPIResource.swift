//
//  Generation+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/03/2025.
//

import Foundation

extension Generation: PokeAPIResource {
    static var resourceRootPath = "generation"

    @available(*, deprecated, message: "⚠️ do not use with this kind of model : API forbidden")
    static func selectAll(from _: Int = 0, count _: Int = 20) async throws -> [Generation] {
        throw PokeAPIResourceError.forbiddenResource
    }

    public static func selectOne(by id: Int) async throws -> Generation {
        try await PokeAPIService<Generation>.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    public static func selectOne(by name: String) async throws -> Generation {
        try await PokeAPIService<Generation>.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    @available(*, deprecated, message: "⚠️ do not use with this kind of model : API forbidden")
    static func baseResources(from _: Int, count _: Int) async throws -> [BaseResource] {
        throw PokeAPIResourceError.forbiddenResource
    }
}
