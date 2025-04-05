//
//  GameVersion+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 28/03/2025.
//

import Foundation

extension GameVersion: PokeAPIResource {
    static var resourceRootPath = "version"

    static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [GameVersion] {
        let apiResources = try await baseResources(from: offset, count: limit)
        let gameVersions = try await withThrowingTaskGroup(of: GameVersion.self, returning: [GameVersion].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [GameVersion]()) { $0.append($1) }
        }
        return gameVersions.sorted { $0.id < $1.id }
    }

    static func selectOne(by id: Int) async throws -> GameVersion {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    static func selectOne(by name: String) async throws -> GameVersion {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    static func baseResources(from offset: Int, count limit: Int) async throws -> [BaseResource] {
        let params = ["offset": String(offset), "limit": String(limit)]
        let baseResult = try await PokeAPIService<BaseResult>.fetchData(from: .list(rootPath: resourceRootPath), with: params)
        return baseResult.resources
    }
}
