//
//  VersionGroupTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 12/04/2025.
//

@testable import PokeAPIService
import Testing

struct VersionGroupTest {
    // MARK: - Base Resources

    @Test func testFecthBaseResources() async throws {
        let lightResources = try await VersionGroup.lightResources(from: 0, count: 10)
        #expect(lightResources.count == 10)
        #expect(lightResources.last?.id == "10")
        #expect(lightResources.first?.id == "1")
        #expect(lightResources.first?.name == "red-blue")
        #expect(lightResources.first?.type == "version-group")
    }

    @Test func testFecthPaginatedBaseResources() async throws {
        let lightResources = try await VersionGroup.lightResources(from: 10, count: 10)
        #expect(lightResources.count == 10)
        #expect(lightResources.last?.id == "20")
        #expect(lightResources.first?.id == "11")
        #expect(lightResources.first?.name == "black-white")
        #expect(lightResources.first?.type == "version-group")
    }

    // MARK: - Select All

    @Test func testSelectDefaultGroupOfVersionGroup() async throws {
        let group = try await VersionGroup.selectAll()
        #expect(group.count == 20)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "red-blue")
        #expect(group.last?.id == 20)
        #expect(group.last?.name.lowercased() == "sword-shield")
    }

    @Test func testSelectLimitedGroupOfVersionGroup() async throws {
        let group = try await VersionGroup.selectAll(count: 25)
        #expect(group.count == 25)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "red-blue")
        #expect(group.last?.id == 25)
        #expect(group.last?.name.lowercased() == "scarlet-violet")
    }

    @Test func testSelectPaginatedGroupOfVersionGroup() async throws {
        let group = try await VersionGroup.selectAll(from: 10, count: 10)
        #expect(group.count == 10)
        #expect(group.first?.id == 11)
        #expect(group.first?.name.lowercased() == "black-white")
        #expect(group.last?.id == 20)
        #expect(group.last?.name.lowercased() == "sword-shield")
    }

    // MARK: - Select One By ID

    @Test func testSelectRedBlueByID() async throws {
        let versionGroup = try await VersionGroup.selectOne(by: 1)
        #expect(versionGroup.id == 1)
        #expect(versionGroup.name == "red-blue")
        #expect(versionGroup.generation.name == "generation-i")
        #expect(versionGroup.pokedexes.contains(where: { $0.name == "kanto" }))
        #expect(versionGroup.regions.contains(where: { $0.name == "kanto" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "red" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "blue" }))
    }

    @Test func testSelectGoldSilverByID() async throws {
        let versionGroup = try await VersionGroup.selectOne(by: 3)
        #expect(versionGroup.id == 3)
        #expect(versionGroup.name == "gold-silver")
        #expect(versionGroup.generation.name == "generation-ii")
        #expect(versionGroup.pokedexes.contains(where: { $0.name == "original-johto" }))
        #expect(versionGroup.regions.contains(where: { $0.name == "johto" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "gold" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "silver" }))
    }

    @Test func testSelectBlackWhiteByID() async throws {
        let versionGroup = try await VersionGroup.selectOne(by: 11)
        #expect(versionGroup.id == 11)
        #expect(versionGroup.name == "black-white")
        #expect(versionGroup.generation.name == "generation-v")
        #expect(versionGroup.pokedexes.contains(where: { $0.name == "original-unova" }))
        #expect(versionGroup.regions.contains(where: { $0.name == "unova" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "black" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "white" }))
    }

    @Test func testSelectSunMoonByID() async throws {
        let versionGroup = try await VersionGroup.selectOne(by: 17)
        #expect(versionGroup.id == 17)
        #expect(versionGroup.name == "sun-moon")
        #expect(versionGroup.generation.name == "generation-vii")
        #expect(versionGroup.pokedexes.contains(where: { $0.name == "original-alola" }))
        #expect(versionGroup.regions.contains(where: { $0.name == "alola" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "sun" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "moon" }))
    }

    @Test func testSelectSwordShieldByID() async throws {
        let versionGroup = try await VersionGroup.selectOne(by: 20)
        #expect(versionGroup.id == 20)
        #expect(versionGroup.name == "sword-shield")
        #expect(versionGroup.generation.name == "generation-viii")
        #expect(versionGroup.pokedexes.contains(where: { $0.name == "galar" }))
        #expect(versionGroup.regions.contains(where: { $0.name == "galar" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "sword" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "shield" }))
    }

    @Test func testSelectScarletVioletByID() async throws {
        let versionGroup = try await VersionGroup.selectOne(by: 25)
        #expect(versionGroup.id == 25)
        #expect(versionGroup.name == "scarlet-violet")
        #expect(versionGroup.generation.name == "generation-ix")
        #expect(versionGroup.pokedexes.contains(where: { $0.name == "paldea" }))
        #expect(versionGroup.regions.contains(where: { $0.name == "paldea" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "scarlet" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "violet" }))
    }

    // MARK: - Select One By Name

    @Test func testSelectRedBlueByName() async throws {
        let versionGroup = try await VersionGroup.selectOne(by: "red-blue")
        #expect(versionGroup.id == 1)
        #expect(versionGroup.name == "red-blue")
        #expect(versionGroup.generation.name == "generation-i")
        #expect(versionGroup.pokedexes.contains(where: { $0.name == "kanto" }))
        #expect(versionGroup.regions.contains(where: { $0.name == "kanto" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "red" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "blue" }))
    }

    @Test func testSelectGoldSilverByName() async throws {
        let versionGroup = try await VersionGroup.selectOne(by: "gold-silver")
        #expect(versionGroup.id == 3)
        #expect(versionGroup.name == "gold-silver")
        #expect(versionGroup.generation.name == "generation-ii")
        #expect(versionGroup.pokedexes.contains(where: { $0.name == "original-johto" }))
        #expect(versionGroup.regions.contains(where: { $0.name == "johto" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "gold" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "silver" }))
    }

    @Test func testSelectBlackWhiteByName() async throws {
        let versionGroup = try await VersionGroup.selectOne(by: "black-white")
        #expect(versionGroup.id == 11)
        #expect(versionGroup.name == "black-white")
        #expect(versionGroup.generation.name == "generation-v")
        #expect(versionGroup.pokedexes.contains(where: { $0.name == "original-unova" }))
        #expect(versionGroup.regions.contains(where: { $0.name == "unova" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "black" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "white" }))
    }

    @Test func testSelectSunMoonByName() async throws {
        let versionGroup = try await VersionGroup.selectOne(by: "sun-moon")
        #expect(versionGroup.id == 17)
        #expect(versionGroup.name == "sun-moon")
        #expect(versionGroup.generation.name == "generation-vii")
        #expect(versionGroup.pokedexes.contains(where: { $0.name == "original-alola" }))
        #expect(versionGroup.regions.contains(where: { $0.name == "alola" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "sun" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "moon" }))
    }

    @Test func testSelectSwordShieldByName() async throws {
        let versionGroup = try await VersionGroup.selectOne(by: "sword-shield")
        #expect(versionGroup.id == 20)
        #expect(versionGroup.name == "sword-shield")
        #expect(versionGroup.generation.name == "generation-viii")
        #expect(versionGroup.pokedexes.contains(where: { $0.name == "galar" }))
        #expect(versionGroup.regions.contains(where: { $0.name == "galar" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "sword" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "shield" }))
    }

    @Test func testSelectScarletVioletByName() async throws {
        let versionGroup = try await VersionGroup.selectOne(by: "scarlet-violet")
        #expect(versionGroup.id == 25)
        #expect(versionGroup.name == "scarlet-violet")
        #expect(versionGroup.generation.name == "generation-ix")
        #expect(versionGroup.pokedexes.contains(where: { $0.name == "paldea" }))
        #expect(versionGroup.regions.contains(where: { $0.name == "paldea" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "scarlet" }))
        #expect(versionGroup.versions.contains(where: { $0.name == "violet" }))
    }

    // MARK: - Random

    @Test func testOptionalOnRandomVersionGroup() async throws {
        let randomID = Int.random(in: 1 ... 27)
        PokeLogger.info("Select VersionGroup ID: \(randomID)")
        _ = try await VersionGroup.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func testSelectInexistingVersionGroup() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await VersionGroup.selectOne(by: "unknown")
        })
    }
}
