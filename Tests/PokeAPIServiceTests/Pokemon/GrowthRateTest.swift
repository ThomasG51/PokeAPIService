//
//  GrowthRateTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 03/05/2025.
//

@testable import PokeAPIService
import Testing

struct GrowthRateTest {
    // MARK: - Base Resources

    @Test func testFecthBaseResources() async throws {
        let lightResources = try await GrowthRate.lightResources(from: 0, count: 2)
        #expect(lightResources.count == 2)
        #expect(lightResources.last?.id == "2")
        #expect(lightResources.first?.id == "1")
        #expect(lightResources.first?.name == "slow")
        #expect(lightResources.first?.type == "growth-rate")
    }

    @Test func testFecthPaginatedBaseResources() async throws {
        let lightResources = try await GrowthRate.lightResources(from: 2, count: 4)
        #expect(lightResources.count == 4)
        #expect(lightResources.first?.id == "3")
        #expect(lightResources.first?.name == "fast")
        #expect(lightResources.first?.type == "growth-rate")
    }

    // MARK: - Select All

    @Test func testSelectDefaultGroupOfGrowthRate() async throws {
        let group = try await GrowthRate.selectAll()
        #expect(group.count == 6)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "slow")
        #expect(group.last?.id == 6)
        #expect(group.last?.name.lowercased() == "fast-then-very-slow")
    }

    @Test func testSelectLimitedGroupOfGrowthRate() async throws {
        let group = try await GrowthRate.selectAll(count: 2)
        #expect(group.count == 2)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "slow")
        #expect(group.last?.id == 2)
        #expect(group.last?.name.lowercased() == "medium")
    }

    @Test func testSelectPaginatedGroupOfGrowthRate() async throws {
        let group = try await GrowthRate.selectAll(from: 3, count: 3)
        #expect(group.count == 3)
        #expect(group.first?.id == 4)
        #expect(group.first?.name.lowercased() == "medium-slow")
    }

    // MARK: - Select One By ID

    @Test func testSelectSlowByID() async throws {
        let slow = try await GrowthRate.selectOne(by: 1)
        #expect(slow.id == 1)
        #expect(slow.name.lowercased() == "slow")
        #expect(slow.levels.contains(where: { $0.level == 100 && $0.experience == 1_250_000 }))
        #expect(slow.descriptions.contains(where: { $0.description.lowercased() == "slow" }))
        print(slow.pokemonSpecies.contains(where: { $0.name.lowercased() == "bulbasaur" }))
    }

    @Test func testSelectFastByID() async throws {
        let slow = try await GrowthRate.selectOne(by: 3)
        #expect(slow.id == 3)
        #expect(slow.name.lowercased() == "fast")
        #expect(slow.levels.contains(where: { $0.level == 100 && $0.experience == 800_000 }))
        #expect(slow.descriptions.contains(where: { $0.description.lowercased() == "fast" }))
        print(slow.pokemonSpecies.contains(where: { $0.name.lowercased() == "azurill" }))
    }

    @Test func testSelectFastThenVerySlowByID() async throws {
        let slow = try await GrowthRate.selectOne(by: 6)
        #expect(slow.id == 6)
        #expect(slow.name.lowercased() == "fast-then-very-slow")
        #expect(slow.levels.contains(where: { $0.level == 100 && $0.experience == 1_640_000 }))
        #expect(slow.descriptions.contains(where: { $0.description.lowercased() == "fluctuating" }))
        print(slow.pokemonSpecies.contains(where: { $0.name.lowercased() == "gulpin" }))
    }

    // MARK: - Select One By Name

    @Test func testSelectSlowByName() async throws {
        let slow = try await GrowthRate.selectOne(by: "slow")
        #expect(slow.id == 1)
        #expect(slow.name.lowercased() == "slow")
        #expect(slow.levels.contains(where: { $0.level == 100 && $0.experience == 1_250_000 }))
        #expect(slow.descriptions.contains(where: { $0.description.lowercased() == "slow" }))
        print(slow.pokemonSpecies.contains(where: { $0.name.lowercased() == "bulbasaur" }))
    }

    @Test func testSelectFastByName() async throws {
        let slow = try await GrowthRate.selectOne(by: "fast")
        #expect(slow.id == 3)
        #expect(slow.name.lowercased() == "fast")
        #expect(slow.levels.contains(where: { $0.level == 100 && $0.experience == 800_000 }))
        #expect(slow.descriptions.contains(where: { $0.description.lowercased() == "fast" }))
        print(slow.pokemonSpecies.contains(where: { $0.name.lowercased() == "azurill" }))
    }

    @Test func testSelectFastThenVerySlowByName() async throws {
        let slow = try await GrowthRate.selectOne(by: "fast-then-very-slow")
        #expect(slow.id == 6)
        #expect(slow.name.lowercased() == "fast-then-very-slow")
        #expect(slow.levels.contains(where: { $0.level == 100 && $0.experience == 1_640_000 }))
        #expect(slow.descriptions.contains(where: { $0.description.lowercased() == "fluctuating" }))
        print(slow.pokemonSpecies.contains(where: { $0.name.lowercased() == "gulpin" }))
    }

    // MARK: - Random

    @Test func testOptionalOnRandomGrowthRate() async throws {
        let randomID = Int.random(in: 1 ... 6)
        PokeLogger.info("GrowthRate ID: \(randomID)")
        _ = try await GrowthRate.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func testFetchInexistingGrowthRate() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await GrowthRate.selectOne(by: "unknown")
        })
    }
}
