//
//  Ability+PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/04/2025.
//

import Foundation

extension Ability: PokeAPIResource {
    /// The Pokemon API resource root path
    ///
    static var resourceRootPath = "ability"

    /// Get a list of Ability
    ///
    /// Without function parameters, the count parameter is set to 20 by default.
    /// ```swift
    /// Task {
    ///     do {
    ///         let abilities = try await Ability.selectAll()
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Set a precise count to fetch as many Ability as you need.
    /// ```swift
    /// Task {
    ///     do {
    ///         let abilities = try await Ability.selectAll(count: 200)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// Choose where to start and how many Ability you want to fetch.
    /// ```swift
    /// Task {
    ///     do {
    ///         let abilities = try await Ability.selectAll(from: 100, count: 100)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters offset: The pagination offset
    /// - Parameters limit: The pagination limit
    /// - Returns: A list of Ability
    ///
    public static func selectAll(from offset: Int = 0, count limit: Int = 20) async throws -> [Ability] {
        let apiResources = try await baseResources(from: offset, count: limit)
        let abilityList = try await withThrowingTaskGroup(of: Ability.self, returning: [Ability].self) { group in
            for resource in apiResources {
                group.addTask { try await selectOne(by: resource.id) }
            }
            return try await group.reduce(into: [Ability]()) { $0.append($1) }
        }
        return abilityList.sorted { $0.id < $1.id }
    }

    /// Get an Ability using its ID
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let abilityID: Int = 15
    ///         let insomnia = try await Ability.selectOne(by: abilityID)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter id: The Ability ID
    /// - Returns: An Ability
    ///
    public static func selectOne(by id: Int) async throws -> Ability {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: String(id)))
    }

    /// Get an Ability using its name
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let abilityName = "insomnia"
    ///         let insomnia = try await Ability.selectOne(by: abilityName)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter name: The Ability name
    /// - Returns: An Ability
    ///
    public static func selectOne(by name: String) async throws -> Ability {
        try await PokeAPIService.fetchData(from: .resource(rootPath: resourceRootPath, value: name))
    }

    /// Get a list of Ability API base resources
    ///
    /// ```swift
    /// Task {
    ///     do {
    ///         let baseResources = try await Ability.baseResources(from: 0, count: 200)
    ///     } catch {
    ///         print(error.localizedDescription)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters offset: The pagination offset
    /// - Parameters limit: The pagination limit
    /// - Returns: A list of light API base resources containing only an ID, a name and a type
    ///
    public static func baseResources(from offset: Int, count limit: Int) async throws -> [BaseResource] {
        let params = ["offset": String(offset), "limit": String(limit)]
        let baseResult = try await PokeAPIService<APIResult>.fetchData(from: .list(rootPath: resourceRootPath), with: params)
        return baseResult.resources
    }
}
