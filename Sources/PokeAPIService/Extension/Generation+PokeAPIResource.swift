//
//  Generation+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/03/2025.
//

import Foundation

extension Generation: PokeAPIResource {
    static var resourceRootPath = "generation"

    static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [Generation] {
        let apiResources = try await baseResources(from: offset, count: limit)
        let generations = try await withThrowingTaskGroup(of: Generation.self, returning: [Generation].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [Generation]()) { $0.append($1) }
        }
        return generations.sorted { $0.id < $1.id }
    }

    public static func selectOne(by id: Int) async throws -> Generation {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    public static func selectOne(by name: String) async throws -> Generation {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    static func baseResources(from offset: Int, count limit: Int) async throws -> [BaseResource] {
        let params = ["offset": String(offset), "limit": String(limit)]
        let baseResult = try await PokeAPIService<BaseResult>.fetchData(from: .list(rootPath: resourceRootPath), with: params)
        return baseResult.resources
    }
}
