//
//  PokemonTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 01/03/2025.
//

@testable import PokeAPIService
import Testing

struct PokemonTest {
    @Test func testAPIResourcesWithPagination() async throws {
        let firstBaseResources = try await Pokemon.baseResources(from: 0, count: 60)
        #expect(firstBaseResources.count == 60)
        #expect(firstBaseResources.last?.id == "60")
        #expect(firstBaseResources.first?.id == "1")
        #expect(firstBaseResources.first?.name == "bulbasaur")
        #expect(firstBaseResources.first?.type == "pokemon")

        let secondBaseResources = try await Pokemon.baseResources(from: 60, count: 60)
        #expect(secondBaseResources.count == 60)
        #expect(secondBaseResources.last?.id == "120")
        #expect(secondBaseResources.first?.id == "61")
        #expect(secondBaseResources.first?.name == "poliwhirl")
        #expect(secondBaseResources.first?.type == "pokemon")
    }

    @Test func testSelectFirstGeneration() async throws {
        let firstGeneration = try await Pokemon.selectAll(count: 151)
        #expect(firstGeneration.count == 151)
        #expect(firstGeneration.first?.id == 1)
        #expect(firstGeneration.first?.name.lowercased() == "bulbasaur")
        #expect(firstGeneration.last?.id == 151)
        #expect(firstGeneration.last?.name.lowercased() == "mew")
    }

    @Test func testSelectSecondGeneration() async throws {
        let secondGeneration = try await Pokemon.selectAll(from: 151, count: 100)
        #expect(secondGeneration.count == 100)
        #expect(secondGeneration.first?.id == 152)
        #expect(secondGeneration.first?.name.lowercased() == "chikorita")
        #expect(secondGeneration.last?.id == 251)
        #expect(secondGeneration.last?.name.lowercased() == "celebi")
    }

    @Test func testFetchOnePokemonByID() async throws {
        let bulbizare = try await Pokemon.selectOne(by: 1)
        #expect(bulbizare != nil)
        #expect(bulbizare.id == 1)
        #expect(bulbizare.name.lowercased() == "bulbasaur")
    }

    @Test func testFetchOnePokemonByName() async throws {
        let bulbizare = try await Pokemon.selectOne(by: "bulbasaur")
        #expect(bulbizare != nil)
        #expect(bulbizare.id == 1)
        #expect(bulbizare.name.lowercased() == "bulbasaur")
    }
}
