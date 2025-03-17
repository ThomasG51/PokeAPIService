//
//  PokemonTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 01/03/2025.
//

@testable import PokeAPIService
import Testing

struct PokemonTest {
    @Test func test_url_list_pagination() async throws {
        let firstURLs = try await Pokemon.urls(from: 0, count: 60)
        #expect(firstURLs.count == 60)
        #expect(firstURLs.reversed().first?.split(separator: "/").last == "60")

        let secondURLs = try await Pokemon.urls(from: 60, count: 60)
        #expect(secondURLs.count == 60)
        #expect(secondURLs.reversed().first?.split(separator: "/").last == "120")
    }

    @Test func test_select_first_generation() async throws {
        let firstGeneration = try await Pokemon.selectAll(count: 151)
        #expect(firstGeneration.count == 151)
    }

    @Test func test_fetch_one_pokemon() async throws {
        let bulbizare = try await Pokemon.selectOne(by: 1)
        #expect(bulbizare != nil)
        #expect(bulbizare.id == 1)
        #expect(bulbizare.name.lowercased() == "bulbasaur")
        dump(bulbizare)
    }
}
