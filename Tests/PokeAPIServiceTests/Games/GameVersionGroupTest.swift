//
//  GameVersionGroupTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 12/04/2025.
//

@testable import PokeAPIService
import Testing

struct GameVersionGroupTest {
    // MARK: - Base Resources

    @Test func testFecthBaseResources() async throws {
        let baseResources = try await GameVersionGroup.baseResources(from: 0, count: 10)
        #expect(baseResources.count == 10)
        #expect(baseResources.last?.id == "10")
        #expect(baseResources.first?.id == "1")
        #expect(baseResources.first?.name == "red-blue")
        #expect(baseResources.first?.type == "version-group")
    }

    @Test func testFecthPaginatedBaseResources() async throws {
        let baseResources = try await GameVersionGroup.baseResources(from: 10, count: 10)
        #expect(baseResources.count == 10)
        #expect(baseResources.last?.id == "20")
        #expect(baseResources.first?.id == "11")
        #expect(baseResources.first?.name == "black-white")
        #expect(baseResources.first?.type == "version-group")
    }

    // MARK: - Select All

    @Test func testSelectDefaultGroupOfGameVersionGroup() async throws {
        let group = try await GameVersionGroup.selectAll()
        #expect(group.count == 20)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "red-blue")
        #expect(group.last?.id == 20)
        #expect(group.last?.name.lowercased() == "sword-shield")
    }

    @Test func testSelectLimitedGroupOfGameVersionGroup() async throws {
        let group = try await GameVersionGroup.selectAll(count: 25)
        #expect(group.count == 25)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "red-blue")
        #expect(group.last?.id == 25)
        #expect(group.last?.name.lowercased() == "scarlet-violet")
    }

    @Test func testSelectPaginatedGroupOfGameVersionGroup() async throws {
        let group = try await GameVersionGroup.selectAll(from: 10, count: 10)
        #expect(group.count == 10)
        #expect(group.first?.id == 11)
        #expect(group.first?.name.lowercased() == "black-white")
        #expect(group.last?.id == 20)
        #expect(group.last?.name.lowercased() == "sword-shield")
    }

    // MARK: - Select One By ID

    @Test func testSelectRedBlueByID() async throws {
        let gameVersionGroup = try await GameVersionGroup.selectOne(by: 1)
        #expect(gameVersionGroup.id == 1)
        #expect(gameVersionGroup.name == "red-blue")
        #expect(gameVersionGroup.generation.name == "generation-i")
        #expect(gameVersionGroup.pokedexes.contains(where: { $0.name == "kanto" }))
        #expect(gameVersionGroup.regions.contains(where: { $0.name == "kanto" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "red" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "blue" }))
    }

    @Test func testSelectGoldSilverByID() async throws {
        let gameVersionGroup = try await GameVersionGroup.selectOne(by: 3)
        #expect(gameVersionGroup.id == 3)
        #expect(gameVersionGroup.name == "gold-silver")
        #expect(gameVersionGroup.generation.name == "generation-ii")
        #expect(gameVersionGroup.pokedexes.contains(where: { $0.name == "original-johto" }))
        #expect(gameVersionGroup.regions.contains(where: { $0.name == "johto" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "gold" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "silver" }))
    }

    @Test func testSelectBlackWhiteByID() async throws {
        let gameVersionGroup = try await GameVersionGroup.selectOne(by: 11)
        #expect(gameVersionGroup.id == 11)
        #expect(gameVersionGroup.name == "black-white")
        #expect(gameVersionGroup.generation.name == "generation-v")
        #expect(gameVersionGroup.pokedexes.contains(where: { $0.name == "original-unova" }))
        #expect(gameVersionGroup.regions.contains(where: { $0.name == "unova" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "black" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "white" }))
    }

    @Test func testSelectSunMoonByID() async throws {
        let gameVersionGroup = try await GameVersionGroup.selectOne(by: 17)
        #expect(gameVersionGroup.id == 17)
        #expect(gameVersionGroup.name == "sun-moon")
        #expect(gameVersionGroup.generation.name == "generation-vii")
        #expect(gameVersionGroup.pokedexes.contains(where: { $0.name == "original-alola" }))
        #expect(gameVersionGroup.regions.contains(where: { $0.name == "alola" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "sun" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "moon" }))
    }

    @Test func testSelectSwordShieldByID() async throws {
        let gameVersionGroup = try await GameVersionGroup.selectOne(by: 20)
        #expect(gameVersionGroup.id == 20)
        #expect(gameVersionGroup.name == "sword-shield")
        #expect(gameVersionGroup.generation.name == "generation-viii")
        #expect(gameVersionGroup.pokedexes.contains(where: { $0.name == "galar" }))
        #expect(gameVersionGroup.regions.contains(where: { $0.name == "galar" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "sword" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "shield" }))
    }

    @Test func testSelectScarletVioletByID() async throws {
        let gameVersionGroup = try await GameVersionGroup.selectOne(by: 25)
        #expect(gameVersionGroup.id == 25)
        #expect(gameVersionGroup.name == "scarlet-violet")
        #expect(gameVersionGroup.generation.name == "generation-ix")
        #expect(gameVersionGroup.pokedexes.contains(where: { $0.name == "paldea" }))
        #expect(gameVersionGroup.regions.contains(where: { $0.name == "paldea" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "scarlet" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "violet" }))
    }

    // MARK: - Select One By Name

    @Test func testSelectRedBlueByName() async throws {
        let gameVersionGroup = try await GameVersionGroup.selectOne(by: "red-blue")
        #expect(gameVersionGroup.id == 1)
        #expect(gameVersionGroup.name == "red-blue")
        #expect(gameVersionGroup.generation.name == "generation-i")
        #expect(gameVersionGroup.pokedexes.contains(where: { $0.name == "kanto" }))
        #expect(gameVersionGroup.regions.contains(where: { $0.name == "kanto" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "red" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "blue" }))
    }

    @Test func testSelectGoldSilverByName() async throws {
        let gameVersionGroup = try await GameVersionGroup.selectOne(by: "gold-silver")
        #expect(gameVersionGroup.id == 3)
        #expect(gameVersionGroup.name == "gold-silver")
        #expect(gameVersionGroup.generation.name == "generation-ii")
        #expect(gameVersionGroup.pokedexes.contains(where: { $0.name == "original-johto" }))
        #expect(gameVersionGroup.regions.contains(where: { $0.name == "johto" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "gold" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "silver" }))
    }

    @Test func testSelectBlackWhiteByName() async throws {
        let gameVersionGroup = try await GameVersionGroup.selectOne(by: "black-white")
        #expect(gameVersionGroup.id == 11)
        #expect(gameVersionGroup.name == "black-white")
        #expect(gameVersionGroup.generation.name == "generation-v")
        #expect(gameVersionGroup.pokedexes.contains(where: { $0.name == "original-unova" }))
        #expect(gameVersionGroup.regions.contains(where: { $0.name == "unova" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "black" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "white" }))
    }

    @Test func testSelectSunMoonByName() async throws {
        let gameVersionGroup = try await GameVersionGroup.selectOne(by: "sun-moon")
        #expect(gameVersionGroup.id == 17)
        #expect(gameVersionGroup.name == "sun-moon")
        #expect(gameVersionGroup.generation.name == "generation-vii")
        #expect(gameVersionGroup.pokedexes.contains(where: { $0.name == "original-alola" }))
        #expect(gameVersionGroup.regions.contains(where: { $0.name == "alola" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "sun" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "moon" }))
    }

    @Test func testSelectSwordShieldByName() async throws {
        let gameVersionGroup = try await GameVersionGroup.selectOne(by: "sword-shield")
        #expect(gameVersionGroup.id == 20)
        #expect(gameVersionGroup.name == "sword-shield")
        #expect(gameVersionGroup.generation.name == "generation-viii")
        #expect(gameVersionGroup.pokedexes.contains(where: { $0.name == "galar" }))
        #expect(gameVersionGroup.regions.contains(where: { $0.name == "galar" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "sword" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "shield" }))
    }

    @Test func testSelectScarletVioletByName() async throws {
        let gameVersionGroup = try await GameVersionGroup.selectOne(by: "scarlet-violet")
        #expect(gameVersionGroup.id == 25)
        #expect(gameVersionGroup.name == "scarlet-violet")
        #expect(gameVersionGroup.generation.name == "generation-ix")
        #expect(gameVersionGroup.pokedexes.contains(where: { $0.name == "paldea" }))
        #expect(gameVersionGroup.regions.contains(where: { $0.name == "paldea" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "scarlet" }))
        #expect(gameVersionGroup.versions.contains(where: { $0.name == "violet" }))
    }

    // MARK: - Random

    @Test func testOptionalOnRandomGameVersionGroup() async throws {
        let randomID = Int.random(in: 1 ... 27)
        PokeLogger.info("Select GameVersionGroup ID: \(randomID)")
        _ = try await GameVersionGroup.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func testSelectInexistingGameVersionGroup() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await GameVersionGroup.selectOne(by: "unknown")
        })
    }
}
