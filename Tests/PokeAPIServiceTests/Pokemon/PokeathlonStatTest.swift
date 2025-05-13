//
//  PokeathlonStatTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 13/05/2025.
//

@testable import PokeAPIService
import Testing

struct PokeathlonStatTest {
    // MARK: - Base Resources

    @Test func fecthBaseResources() async throws {
        let lightResources = try await PokeathlonStat.lightResources(from: 0, count: 5)
        #expect(lightResources.count == 5)
        #expect(lightResources.last?.id == "5")
        #expect(lightResources.first?.id == "1")
        #expect(lightResources.first?.name == "speed")
        #expect(lightResources.first?.type == "pokeathlon-stat")
    }

    @Test func fecthPaginatedBaseResources() async throws {
        let lightResources = try await PokeathlonStat.lightResources(from: 2, count: 3)
        #expect(lightResources.count == 3)
        #expect(lightResources.first?.id == "3")
        #expect(lightResources.first?.name == "skill")
        #expect(lightResources.first?.type == "pokeathlon-stat")
    }

    // MARK: - Select All

    @Test func selectDefaultGroupOfPokeathlonStat() async throws {
        let group = try await PokeathlonStat.selectAll()
        #expect(group.count == 5)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "speed")
        #expect(group.last?.id == 5)
        #expect(group.last?.name.lowercased() == "jump")
    }

    @Test func selectLimitedGroupOfPokeathlonStat() async throws {
        let group = try await PokeathlonStat.selectAll(count: 2)
        #expect(group.count == 2)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "speed")
        #expect(group.last?.id == 2)
        #expect(group.last?.name.lowercased() == "power")
    }

    @Test func selectPaginatedGroupOfPokeathlonStat() async throws {
        let group = try await PokeathlonStat.selectAll(from: 2, count: 2)
        #expect(group.count == 2)
        #expect(group.first?.id == 3)
        #expect(group.first?.name.lowercased() == "skill")
        #expect(group.last?.id == 4)
        #expect(group.last?.name.lowercased() == "stamina")
    }

    // MARK: - Select One By ID

    @Test func selectSpeedByID() async throws {
        let speed = try await PokeathlonStat.selectOne(by: 1)
        #expect(speed.id == 1)
        #expect(speed.name.lowercased() == "speed")
        #expect(speed.affectingNatures.increase.contains(where: { $0.nature.name.lowercased() == "jolly" }))
        #expect(speed.affectingNatures.decrease.contains(where: { $0.nature.name.lowercased() == "calm" }))
    }

    @Test func selectSkillByID() async throws {
        let skill = try await PokeathlonStat.selectOne(by: 3)
        #expect(skill.id == 3)
        #expect(skill.name.lowercased() == "skill")
        #expect(skill.affectingNatures.increase.contains(where: { $0.nature.name.lowercased() == "docile" }))
        #expect(skill.affectingNatures.decrease.contains(where: { $0.nature.name.lowercased() == "gentle" }))
    }

    @Test func selectJumpByID() async throws {
        let jump = try await PokeathlonStat.selectOne(by: 5)
        #expect(jump.id == 5)
        #expect(jump.name.lowercased() == "jump")
        #expect(jump.affectingNatures.increase.contains(where: { $0.nature.name.lowercased() == "modest" }))
        #expect(jump.affectingNatures.decrease.contains(where: { $0.nature.name.lowercased() == "adamant" }))
    }

    // MARK: - Select One By Name

    @Test func selectSpeedByName() async throws {
        let speed = try await PokeathlonStat.selectOne(by: "speed")
        #expect(speed.id == 1)
        #expect(speed.name.lowercased() == "speed")
        #expect(speed.affectingNatures.increase.contains(where: { $0.nature.name.lowercased() == "jolly" }))
        #expect(speed.affectingNatures.decrease.contains(where: { $0.nature.name.lowercased() == "calm" }))
    }

    @Test func selectSkillByName() async throws {
        let skill = try await PokeathlonStat.selectOne(by: "skill")
        #expect(skill.id == 3)
        #expect(skill.name.lowercased() == "skill")
        #expect(skill.affectingNatures.increase.contains(where: { $0.nature.name.lowercased() == "docile" }))
        #expect(skill.affectingNatures.decrease.contains(where: { $0.nature.name.lowercased() == "gentle" }))
    }

    @Test func selectJumpByName() async throws {
        let jump = try await PokeathlonStat.selectOne(by: "jump")
        #expect(jump.id == 5)
        #expect(jump.name.lowercased() == "jump")
        #expect(jump.affectingNatures.increase.contains(where: { $0.nature.name.lowercased() == "modest" }))
        #expect(jump.affectingNatures.decrease.contains(where: { $0.nature.name.lowercased() == "adamant" }))
    }

    // MARK: - Random

    @Test func optionalOnRandomPokeathlonStat() async throws {
        let randomID = Int.random(in: 1 ... 5)
        PokeLogger.info("PokeathlonStat ID: \(randomID)")
        _ = try await PokeathlonStat.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func fetchInexistingPokeathlonStat() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await PokeathlonStat.selectOne(by: "unknown")
        })
    }
}
