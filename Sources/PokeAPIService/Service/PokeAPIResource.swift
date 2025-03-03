//
//  PokeAPIResource.swift
//  PokeAPIService
//
//  Created by Thomas George on 01/03/2025.
//

import Foundation

protocol PokeAPIResource where Self: Decodable {
    associatedtype T

    static func selectAll(from offset: Int, count limit: Int) async throws -> [T]
    static func selectOne(by id: Int) async throws -> T
    static func selectOne(by name: String) async throws -> T
    static func urls(from offset: Int, count limit: Int) async throws -> [String]
}
