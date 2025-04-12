//
//  GameVersionGroupTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 12/04/2025.
//

@testable import PokeAPIService
import Testing

struct GameVersionGroupTest {
    @Test func testGameVersionGroupBaseResourceWithPagination() async throws {
        let firstBaseResources = try await GameVersionGroup.baseResources(from: 0, count: 3)
        #expect(firstBaseResources.count == 3)
        #expect(firstBaseResources.first?.id == "1")
        #expect(firstBaseResources.first?.name == "red-blue")
        #expect(firstBaseResources.first?.type == "version-group")
        #expect(firstBaseResources.last?.id == "3")
        #expect(firstBaseResources.last?.name == "gold-silver")
        #expect(firstBaseResources.last?.type == "version-group")
    }

    @Test func testGameVersionGroupSelectAll() async throws {
        let gameVersionGroups = try await GameVersionGroup.selectAll()
        #expect(gameVersionGroups.count == 20)
    }

    @Test func testGameVersionGroupSelectRedBlueByID() async throws {
        let gameVersionGroupRedBlue = try await GameVersionGroup.selectOne(by: 1)
        #expect(gameVersionGroupRedBlue.id == 1)
        #expect(gameVersionGroupRedBlue.name == "red-blue")
        #expect(gameVersionGroupRedBlue.generation.name == "generation-i")
        #expect(gameVersionGroupRedBlue.pokedexes.contains(where: { $0.name == "kanto" }))
        #expect(gameVersionGroupRedBlue.regions.contains(where: { $0.name == "kanto" }))
        #expect(gameVersionGroupRedBlue.versions.contains(where: { $0.name == "red" }))
        #expect(gameVersionGroupRedBlue.versions.contains(where: { $0.name == "blue" }))
    }

    @Test func testGameVersionGroupSelectRedBlueByName() async throws {
        let gameVersionGroupRedBlue = try await GameVersionGroup.selectOne(by: "red-blue")
        #expect(gameVersionGroupRedBlue.id == 1)
        #expect(gameVersionGroupRedBlue.name == "red-blue")
        #expect(gameVersionGroupRedBlue.generation.name == "generation-i")
        #expect(gameVersionGroupRedBlue.pokedexes.contains(where: { $0.name == "kanto" }))
        #expect(gameVersionGroupRedBlue.regions.contains(where: { $0.name == "kanto" }))
        #expect(gameVersionGroupRedBlue.versions.contains(where: { $0.name == "red" }))
        #expect(gameVersionGroupRedBlue.versions.contains(where: { $0.name == "blue" }))
    }

    @Test func testGameVersionGroupSelectGoldSilverByID() async throws {
        let gameVersionGroupGoldSilver = try await GameVersionGroup.selectOne(by: 3)
        #expect(gameVersionGroupGoldSilver.id == 3)
        #expect(gameVersionGroupGoldSilver.name == "gold-silver")
        #expect(gameVersionGroupGoldSilver.generation.name == "generation-ii")
        #expect(gameVersionGroupGoldSilver.pokedexes.contains(where: { $0.name == "original-johto" }))
        #expect(gameVersionGroupGoldSilver.regions.contains(where: { $0.name == "johto" }))
        #expect(gameVersionGroupGoldSilver.versions.contains(where: { $0.name == "gold" }))
        #expect(gameVersionGroupGoldSilver.versions.contains(where: { $0.name == "silver" }))
    }

    @Test func testGameVersionGroupSelectGoldSilverByName() async throws {
        let gameVersionGroupGoldSilver = try await GameVersionGroup.selectOne(by: "gold-silver")
        #expect(gameVersionGroupGoldSilver.id == 3)
        #expect(gameVersionGroupGoldSilver.name == "gold-silver")
        #expect(gameVersionGroupGoldSilver.generation.name == "generation-ii")
        #expect(gameVersionGroupGoldSilver.pokedexes.contains(where: { $0.name == "original-johto" }))
        #expect(gameVersionGroupGoldSilver.regions.contains(where: { $0.name == "johto" }))
        #expect(gameVersionGroupGoldSilver.versions.contains(where: { $0.name == "gold" }))
        #expect(gameVersionGroupGoldSilver.versions.contains(where: { $0.name == "silver" }))
    }

    @Test func testFetchInexistingGameVersionGroup() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await GameVersionGroup.selectOne(by: "unknown")
        })
    }
}
