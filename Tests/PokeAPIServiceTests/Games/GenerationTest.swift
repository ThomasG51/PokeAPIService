//
//  Untitled.swift
//  PokeAPIService
//
//  Created by Thomas George on 12/04/2025.
//

@testable import PokeAPIService
import Testing

struct GenerationTest {
    @Test func testGenerationBaseResourceWithPagination() async throws {
        let firstBaseResources = try await Generation.baseResources(from: 0, count: 3)
        #expect(firstBaseResources.count == 3)
        #expect(firstBaseResources.last?.id == "3")
        #expect(firstBaseResources.first?.id == "1")
        #expect(firstBaseResources.first?.name == "generation-i")
        #expect(firstBaseResources.first?.type == "generation")

        let secondBaseResources = try await Generation.baseResources(from: 3, count: 3)
        #expect(secondBaseResources.count == 3)
        #expect(secondBaseResources.last?.id == "6")
        #expect(secondBaseResources.first?.id == "4")
        #expect(secondBaseResources.first?.name == "generation-iv")
        #expect(secondBaseResources.first?.type == "generation")
    }

    @Test func testGenerationSelectAll() async throws {
        let generations = try await Generation.selectAll(count: 9)
        #expect(generations.count == 9)
    }

    @Test func testGenerationSelectFirstByID() async throws {
        let firstGeneration = try await Generation.selectOne(by: 1)
        #expect(firstGeneration.id == 1)
        #expect(firstGeneration.name == "generation-i")
        #expect(firstGeneration.mainRegion.name == "kanto")
        #expect(firstGeneration.pokemonSpecies.count == 151)
        #expect(firstGeneration.versionGroups.contains(where: { $0.name == "red-blue" }))
        #expect(firstGeneration.versionGroups.contains(where: { $0.name == "yellow" }))
    }

    @Test func testGenerationSelectFirstByName() async throws {
        let firstGeneration = try await Generation.selectOne(by: "generation-i")
        #expect(firstGeneration.id == 1)
        #expect(firstGeneration.name == "generation-i")
        #expect(firstGeneration.mainRegion.name == "kanto")
        #expect(firstGeneration.pokemonSpecies.count == 151)
        #expect(firstGeneration.versionGroups.contains(where: { $0.name == "red-blue" }))
        #expect(firstGeneration.versionGroups.contains(where: { $0.name == "yellow" }))
    }

    @Test func testGenerationSelectSecondByID() async throws {
        let secondGeneration = try await Generation.selectOne(by: 2)
        #expect(secondGeneration.id == 2)
        #expect(secondGeneration.name == "generation-ii")
        #expect(secondGeneration.mainRegion.name == "johto")
        #expect(secondGeneration.pokemonSpecies.count == 100)
        #expect(secondGeneration.versionGroups.contains(where: { $0.name == "gold-silver" }))
        #expect(secondGeneration.versionGroups.contains(where: { $0.name == "crystal" }))
    }

    @Test func testGenerationSelectSecondByName() async throws {
        let secondGeneration = try await Generation.selectOne(by: "generation-ii")
        #expect(secondGeneration.id == 2)
        #expect(secondGeneration.name == "generation-ii")
        #expect(secondGeneration.mainRegion.name == "johto")
        #expect(secondGeneration.pokemonSpecies.count == 100)
        #expect(secondGeneration.versionGroups.contains(where: { $0.name == "gold-silver" }))
        #expect(secondGeneration.versionGroups.contains(where: { $0.name == "crystal" }))
    }

    @Test func testFetchInexistingGeneration() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await Generation.selectOne(by: "unknown")
        })
    }
}
