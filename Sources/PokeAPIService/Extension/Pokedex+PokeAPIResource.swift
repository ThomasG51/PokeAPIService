//
//  Pokedex+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 25/03/2025.
//

import Foundation

extension Pokedex: PokeAPIResource {
    static var resourceRootPath = "pokedex"

    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [Pokedex] {
        let apiResources = try await baseResources(from: offset, count: limit)
        let pokedexes = try await withThrowingTaskGroup(of: Pokedex.self, returning: [Pokedex].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [Pokedex]()) { $0.append($1) }
        }
        return pokedexes.sorted { $0.id < $1.id }
    }

    public static func selectOne(by id: Int) async throws -> Pokedex {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    public static func selectOne(by name: String) async throws -> Pokedex {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    public static func baseResources(from offset: Int, count limit: Int) async throws -> [BaseResource] {
        let params = ["offset": String(offset), "limit": String(limit)]
        let baseResult = try await PokeAPIService<BaseResult>.fetchData(from: .list(rootPath: resourceRootPath), with: params)
        return baseResult.resources
    }
}
