//
//  EggGroupTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 27/04/2025.
//

@testable import PokeAPIService
import Testing

struct EggGroupTest {
    // MARK: - Base Resources

    @Test func fecthBaseResources() async throws {
        let lightResources = try await EggGroup.lightResources(from: 0, count: 10)
        #expect(lightResources.count == 10)
        #expect(lightResources.last?.id == "10")
        #expect(lightResources.first?.id == "1")
        #expect(lightResources.first?.name == "monster")
        #expect(lightResources.first?.type == "egg-group")
    }

    @Test func fecthPaginatedBaseResources() async throws {
        let lightResources = try await EggGroup.lightResources(from: 10, count: 5)
        #expect(lightResources.count == 5)
        #expect(lightResources.last?.id == "15")
        #expect(lightResources.first?.id == "11")
        #expect(lightResources.first?.name == "indeterminate")
        #expect(lightResources.first?.type == "egg-group")
    }

    // MARK: - Select All

    @Test func selectDefaultGroupOfEggGroup() async throws {
        let group = try await EggGroup.selectAll()
        #expect(group.count == 15)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "monster")
        #expect(group.last?.id == 15)
        #expect(group.last?.name.lowercased() == "no-eggs")
    }

    @Test func selectLimitedGroupOfEggGroup() async throws {
        let group = try await EggGroup.selectAll(count: 10)
        #expect(group.count == 10)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "monster")
        #expect(group.last?.id == 10)
        #expect(group.last?.name.lowercased() == "mineral")
    }

    @Test func selectPaginatedGroupOfEggGroup() async throws {
        let group = try await EggGroup.selectAll(from: 5, count: 10)
        #expect(group.count == 10)
        #expect(group.first?.id == 6)
        #expect(group.first?.name.lowercased() == "fairy")
        #expect(group.last?.id == 15)
        #expect(group.last?.name.lowercased() == "no-eggs")
    }

    // MARK: - Select One By ID

    @Test func selectMonsterByID() async throws {
        let monster = try await EggGroup.selectOne(by: 1)
        #expect(monster.id == 1)
        #expect(monster.name.lowercased() == "monster")
        #expect(monster.pokemonSpecies.count == 81)
    }

    @Test func selectGroundByID() async throws {
        let ground = try await EggGroup.selectOne(by: 5)
        #expect(ground.id == 5)
        #expect(ground.name.lowercased() == "ground")
        #expect(ground.pokemonSpecies.count == 278)
    }

    @Test func selectMineralByID() async throws {
        let mineral = try await EggGroup.selectOne(by: 10)
        #expect(mineral.id == 10)
        #expect(mineral.name.lowercased() == "mineral")
        #expect(mineral.pokemonSpecies.count == 84)
    }

    @Test func selectNoEggsByID() async throws {
        let monster = try await EggGroup.selectOne(by: 15)
        #expect(monster.id == 15)
        #expect(monster.name.lowercased() == "no-eggs")
        #expect(monster.pokemonSpecies.count == 151)
    }

    // MARK: - Select One By Name

    @Test func selectMonsterByName() async throws {
        let monster = try await EggGroup.selectOne(by: "monster")
        #expect(monster.id == 1)
        #expect(monster.name.lowercased() == "monster")
        #expect(monster.pokemonSpecies.count == 81)
    }

    @Test func selectGroundByName() async throws {
        let ground = try await EggGroup.selectOne(by: "ground")
        #expect(ground.id == 5)
        #expect(ground.name.lowercased() == "ground")
        #expect(ground.pokemonSpecies.count == 278)
    }

    @Test func selectMineralByName() async throws {
        let mineral = try await EggGroup.selectOne(by: "mineral")
        #expect(mineral.id == 10)
        #expect(mineral.name.lowercased() == "mineral")
        #expect(mineral.pokemonSpecies.count == 84)
    }

    @Test func selectNoEggsByName() async throws {
        let monster = try await EggGroup.selectOne(by: "no-eggs")
        #expect(monster.id == 15)
        #expect(monster.name.lowercased() == "no-eggs")
        #expect(monster.pokemonSpecies.count == 151)
    }

    // MARK: - Random

    @Test func optionalOnRandomEggGroup() async throws {
        let randomID = Int.random(in: 1 ... 15)
        PokeLogger.info("EggGroup ID: \(randomID)")
        _ = try await EggGroup.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func fetchInexistingEggGroup() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await EggGroup.selectOne(by: "unknown")
        })
    }
}
