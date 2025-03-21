//
//  GamesTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/03/2025.
//

@testable import PokeAPIService
import Testing

struct GamesTest {
    @Test func testBaseResource() async throws {
        await #expect(throws: PokeAPIResourceError.forbiddenResource, performing: {
            try await Generation.baseResources(from: 0, count: 2)
        })
    }

    @Test func testSelectAll() async throws {
        await #expect(throws: PokeAPIResourceError.forbiddenResource, performing: {
            try await Generation.selectAll(count: 2)
        })
    }

    @Test func testSelectFirstGenerationByID() async throws {
        let firstGeneration = try await Generation.selectOne(by: 1)
        #expect(firstGeneration.id == 1)
        #expect(firstGeneration.name == "generation-i")
        #expect(firstGeneration.mainRegion.name == "kanto")
        #expect(firstGeneration.pokemonSpecies.count == 151)
        #expect(firstGeneration.versions.contains(where: { $0.name == "red-blue" }))
        #expect(firstGeneration.versions.contains(where: { $0.name == "yellow" }))
    }

    @Test func testSelectFirstGenerationByName() async throws {
        let firstGeneration = try await Generation.selectOne(by: "generation-i")
        #expect(firstGeneration.id == 1)
        #expect(firstGeneration.name == "generation-i")
        #expect(firstGeneration.mainRegion.name == "kanto")
        #expect(firstGeneration.pokemonSpecies.count == 151)
        #expect(firstGeneration.versions.contains(where: { $0.name == "red-blue" }))
        #expect(firstGeneration.versions.contains(where: { $0.name == "yellow" }))
    }

    @Test func testSelectSecondGenerationByID() async throws {
        let secondGeneration = try await Generation.selectOne(by: 2)
        #expect(secondGeneration.id == 2)
        #expect(secondGeneration.name == "generation-ii")
        #expect(secondGeneration.mainRegion.name == "johto")
        #expect(secondGeneration.pokemonSpecies.count == 100)
        #expect(secondGeneration.versions.contains(where: { $0.name == "gold-silver" }))
        #expect(secondGeneration.versions.contains(where: { $0.name == "crystal" }))
    }
}
