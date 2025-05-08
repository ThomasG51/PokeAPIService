//
//  NatureTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 08/05/2025.
//

@testable import PokeAPIService
import Testing

struct NatureTest {
    // MARK: - Base Resources
    
    @Test func testFecthBaseResources() async throws {
        let lightResources = try await Nature.lightResources(from: 0, count: 10)
        #expect(lightResources.count == 10)
        #expect(lightResources.last?.id == "10")
        #expect(lightResources.first?.id == "1")
        #expect(lightResources.first?.name == "hardy")
        #expect(lightResources.first?.type == "nature")
    }

    @Test func testFecthPaginatedBaseResources() async throws {
        let lightResources = try await Nature.lightResources(from: 10, count: 15)
        #expect(lightResources.count == 15)
        #expect(lightResources.first?.id == "11")
        #expect(lightResources.first?.name == "adamant")
        #expect(lightResources.first?.type == "nature")
    }

    // MARK: - Select All
    
    @Test func testSelectDefaultGroupOfNature() async throws {
        let group = try await Nature.selectAll()
        #expect(group.count == 20)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "hardy")
        #expect(group.last?.id == 20)
        #expect(group.last?.name.lowercased() == "naive")
    }

    @Test func testSelectLimitedGroupOfNature() async throws {
        let group = try await Nature.selectAll(count: 25)
        #expect(group.count == 25)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "hardy")
        #expect(group.last?.id == 25)
        #expect(group.last?.name.lowercased() == "serious")
    }

    @Test func testSelectPaginatedGroupOfNature() async throws {
        let group = try await Nature.selectAll(from: 10, count: 15)
        #expect(group.count == 15)
        #expect(group.first?.id == 11)
        #expect(group.first?.name.lowercased() == "adamant")
        #expect(group.last?.id == 25)
        #expect(group.last?.name.lowercased() == "serious")
    }
    
    // MARK: - Select One By ID

    @Test func testSelectHardyByID() async throws {
        let hardy = try await Nature.selectOne(by: 1)
        #expect(hardy.id == 1)
        #expect(hardy.name.lowercased() == "hardy")
        #expect(hardy.decreasedStat == nil)
        #expect(hardy.increasedStat == nil)
        #expect(hardy.moveBattleStylePreferences.contains(where: { $0.moveBattleStyle.name.lowercased() == "attack" }))
    }

    @Test func testSelectGentleByID() async throws {
        let gentle = try await Nature.selectOne(by: 9)
        #expect(gentle.id == 9)
        #expect(gentle.name.lowercased() == "gentle")
        #expect(gentle.decreasedStat?.name.lowercased() == "defense")
        #expect(gentle.increasedStat?.name.lowercased() == "special-defense")
        #expect(gentle.moveBattleStylePreferences.contains(where: { $0.moveBattleStyle.name.lowercased() == "attack" }))
    }

    @Test func testSelectNaiveByID() async throws {
        let naive = try await Nature.selectOne(by: 20)
        #expect(naive.id == 20)
        #expect(naive.name.lowercased() == "naive")
        #expect(naive.decreasedStat?.name.lowercased() == "special-defense")
        #expect(naive.increasedStat?.name.lowercased() == "speed")
        #expect(naive.moveBattleStylePreferences.contains(where: { $0.moveBattleStyle.name.lowercased() == "attack" }))
    }
    
    // MARK: - Select One By Name
    
    @Test func testSelectHardyByName() async throws {
        let hardy = try await Nature.selectOne(by: 1)
        #expect(hardy.id == 1)
        #expect(hardy.name.lowercased() == "hardy")
        #expect(hardy.decreasedStat == nil)
        #expect(hardy.increasedStat == nil)
        #expect(hardy.moveBattleStylePreferences.contains(where: { $0.moveBattleStyle.name.lowercased() == "attack" }))
    }

    @Test func testSelectGentleByName() async throws {
        let gentle = try await Nature.selectOne(by: 9)
        #expect(gentle.id == 9)
        #expect(gentle.name.lowercased() == "gentle")
        #expect(gentle.decreasedStat?.name.lowercased() == "defense")
        #expect(gentle.increasedStat?.name.lowercased() == "special-defense")
        #expect(gentle.moveBattleStylePreferences.contains(where: { $0.moveBattleStyle.name.lowercased() == "attack" }))
    }

    @Test func testSelectNaiveByName() async throws {
        let naive = try await Nature.selectOne(by: 20)
        #expect(naive.id == 20)
        #expect(naive.name.lowercased() == "naive")
        #expect(naive.decreasedStat?.name.lowercased() == "special-defense")
        #expect(naive.increasedStat?.name.lowercased() == "speed")
        #expect(naive.moveBattleStylePreferences.contains(where: { $0.moveBattleStyle.name.lowercased() == "attack" }))
    }
    
    // MARK: - Random

    @Test func testOptionalOnRandomNature() async throws {
        let randomID = Int.random(in: 1 ... 25)
        PokeLogger.info("Nature ID: \(randomID)")
        _ = try await Nature.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func testFetchInexistingNature() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await Nature.selectOne(by: "unknown")
        })
    }
}
