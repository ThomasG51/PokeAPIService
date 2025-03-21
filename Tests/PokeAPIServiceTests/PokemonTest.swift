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
        #expect(firstGeneration.first?.id == 1)
        #expect(firstGeneration.first?.name.lowercased() == "bulbasaur")
        #expect(firstGeneration.last?.id == 151)
        #expect(firstGeneration.last?.name.lowercased() == "mew")
    }

    @Test func test_select_second_generation() async throws {
        let secondGeneration = try await Pokemon.selectAll(from: 151, count: 100)
        #expect(secondGeneration.count == 100)
        #expect(secondGeneration.first?.id == 152)
        #expect(secondGeneration.first?.name.lowercased() == "chikorita")
        #expect(secondGeneration.last?.id == 251)
        #expect(secondGeneration.last?.name.lowercased() == "celebi")
    }

    @Test func test_fetch_one_pokemon_by_id() async throws {
        let bulbizare = try await Pokemon.selectOne(by: 1)
        #expect(bulbizare != nil)
        #expect(bulbizare.id == 1)
        #expect(bulbizare.name.lowercased() == "bulbasaur")
    }

    @Test func test_fetch_one_pokemon_by_name() async throws {
        let bulbizare = try await Pokemon.selectOne(by: "bulbasaur")
        #expect(bulbizare != nil)
        #expect(bulbizare.id == 1)
        #expect(bulbizare.name.lowercased() == "bulbasaur")
    }
}
