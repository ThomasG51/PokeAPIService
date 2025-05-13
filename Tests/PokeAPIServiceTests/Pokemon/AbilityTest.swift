//
//  AbilityTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/04/2025.
//

@testable import PokeAPIService
import Testing

struct AbilityTest {
    // MARK: - Base Resources

    @Test func fecthBaseResources() async throws {
        let lightResources = try await Ability.lightResources(from: 0, count: 100)
        #expect(lightResources.count == 100)
        #expect(lightResources.last?.id == "100")
        #expect(lightResources.first?.id == "1")
        #expect(lightResources.first?.name == "stench")
        #expect(lightResources.first?.type == "ability")
    }

    @Test func fecthPaginatedBaseResources() async throws {
        let lightResources = try await Ability.lightResources(from: 100, count: 100)
        #expect(lightResources.count == 100)
        #expect(lightResources.last?.id == "200")
        #expect(lightResources.first?.id == "101")
        #expect(lightResources.first?.name == "technician")
        #expect(lightResources.first?.type == "ability")
    }

    // MARK: - Select All

    @Test func selectDefaultGroupOfAbility() async throws {
        let group = try await Ability.selectAll()
        #expect(group.count == 20)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "stench")
        #expect(group.last?.id == 20)
        #expect(group.last?.name.lowercased() == "own-tempo")
    }

    @Test func selectLimitedGroupOfAbility() async throws {
        let group = try await Ability.selectAll(count: 200)
        #expect(group.count == 200)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "stench")
        #expect(group.last?.id == 200)
        #expect(group.last?.name.lowercased() == "steelworker")
    }

    @Test func selectPaginatedGroupOfAbility() async throws {
        let group = try await Ability.selectAll(from: 200, count: 100)
        #expect(group.count == 100)
        #expect(group.first?.id == 201)
        #expect(group.first?.name.lowercased() == "berserk")
        #expect(group.last?.id == 300)
        #expect(group.last?.name.lowercased() == "supersweet-syrup")
    }

    // MARK: - Select One By ID

    @Test func selectStenchByID() async throws {
        let stench = try await Ability.selectOne(by: 1)
        #expect(stench.id == 1)
        #expect(stench.name.lowercased() == "stench")
        #expect(stench.isMainSeries)
        #expect(stench.generation.name == "generation-iii")
        #expect(stench.pokemon.contains(where: { $0.pokemon.name == "gloom" }))
        #expect(stench.effectEntries.contains(where: { $0.effect == "This Pokémon's damaging moves have a 10% chance to make the target flinch with each hit if they do not already cause flinching as a secondary effect.\n\nThis ability does not stack with a held item.\n\nOverworld: The wild encounter rate is halved while this Pokémon is first in the party." }))
        #expect(stench.flavorTextEntries.contains(where: { $0.flavorText == "Helps repel wild POKéMON." }))
        #expect(stench.effectChanges.contains(where: {
            $0.effectEntries.contains(where: {
                $0.effect == "Has no effect in battle."
            })
        }))
    }

    @Test func selectRunAwayByID() async throws {
        let runAway = try await Ability.selectOne(by: 50)
        #expect(runAway.id == 50)
        #expect(runAway.name.lowercased() == "run-away")
        #expect(runAway.isMainSeries)
        #expect(runAway.generation.name == "generation-iii")
        #expect(runAway.pokemon.contains(where: { $0.pokemon.name == "ponyta" }))
        #expect(runAway.effectEntries.contains(where: { $0.effect == "This Pokémon is always successful fleeing from wild battles, even if trapped by a move or ability." }))
        #expect(runAway.flavorTextEntries.contains(where: { $0.flavorText == "Makes escaping easier." }))
        // At this point, PokeAPI return an empty array
        #expect(runAway.effectChanges.isEmpty)
    }

    @Test func selectRecklessByID() async throws {
        let reckless = try await Ability.selectOne(by: 120)
        #expect(reckless.id == 120)
        #expect(reckless.name.lowercased() == "reckless")
        #expect(reckless.isMainSeries)
        #expect(reckless.generation.name == "generation-iv")
        #expect(reckless.pokemon.contains(where: { $0.pokemon.name == "rhyhorn" }))
        #expect(reckless.effectEntries.contains(where: { $0.effect == "This Pokémon's recoil moves and crash moves have 1.2× their base power.\n\nstruggle is unaffected.\n\nThe \"crash moves\" are the moves that damage the user upon missing: jump kick and high jump kick." }))
        #expect(reckless.flavorTextEntries.contains(where: { $0.flavorText == "Powers up moves that\nhave recoil damage." }))
        // At this point, PokeAPI return an empty array
        #expect(reckless.effectChanges.isEmpty)
    }

    @Test func selectMimicryByID() async throws {
        let mimicry = try await Ability.selectOne(by: 250)
        #expect(mimicry.id == 250)
        #expect(mimicry.name.lowercased() == "mimicry")
        #expect(mimicry.isMainSeries)
        #expect(mimicry.generation.name == "generation-viii")
        #expect(mimicry.pokemon.contains(where: { $0.pokemon.name == "stunfisk-galar" }))
        #expect(mimicry.effectEntries.contains(where: { $0.effect == "Changes the Pokémon’s type depending on the terrain." }))
        // At this point, PokeAPI return an empty array
        #expect(mimicry.effectChanges.isEmpty)
    }

    @Test func selectSupersweetSyrupByID() async throws {
        let supersweetSyrup = try await Ability.selectOne(by: 300)
        #expect(supersweetSyrup.id == 300)
        #expect(supersweetSyrup.name.lowercased() == "supersweet-syrup")
        #expect(supersweetSyrup.isMainSeries)
        #expect(supersweetSyrup.generation.name == "generation-ix")
        #expect(supersweetSyrup.pokemon.contains(where: { $0.pokemon.name == "dipplin" }))
        #expect(supersweetSyrup.effectEntries.contains(where: { $0.effect == "A sickly sweet scent spreads across the field the first time the Pokémon enters a battle, lowering the evasiveness of opposing Pokémon." }))
        #expect(supersweetSyrup.flavorTextEntries.contains(where: { $0.flavorText == "Lowers the evasion of opposing Pokémon by 1 stage when first sent into battle" }))
        // At this point, PokeAPI return an empty array
        #expect(supersweetSyrup.effectChanges.isEmpty)
    }

    // MARK: - Select One By Name

    @Test func selectStenchByName() async throws {
        let stench = try await Ability.selectOne(by: "stench")
        #expect(stench.id == 1)
        #expect(stench.name.lowercased() == "stench")
        #expect(stench.isMainSeries)
        #expect(stench.generation.name == "generation-iii")
        #expect(stench.pokemon.contains(where: { $0.pokemon.name == "gloom" }))
        #expect(stench.effectEntries.contains(where: { $0.effect == "This Pokémon's damaging moves have a 10% chance to make the target flinch with each hit if they do not already cause flinching as a secondary effect.\n\nThis ability does not stack with a held item.\n\nOverworld: The wild encounter rate is halved while this Pokémon is first in the party." }))
        #expect(stench.flavorTextEntries.contains(where: { $0.flavorText == "Helps repel wild POKéMON." }))
        #expect(stench.effectChanges.contains(where: {
            $0.effectEntries.contains(where: {
                $0.effect == "Has no effect in battle."
            })
        }))
    }

    @Test func selectRunAwayByName() async throws {
        let runAway = try await Ability.selectOne(by: "run-away")
        #expect(runAway.id == 50)
        #expect(runAway.name.lowercased() == "run-away")
        #expect(runAway.isMainSeries)
        #expect(runAway.generation.name == "generation-iii")
        #expect(runAway.pokemon.contains(where: { $0.pokemon.name == "ponyta" }))
        #expect(runAway.effectEntries.contains(where: { $0.effect == "This Pokémon is always successful fleeing from wild battles, even if trapped by a move or ability." }))
        #expect(runAway.flavorTextEntries.contains(where: { $0.flavorText == "Makes escaping easier." }))
        // At this point, PokeAPI return an empty array
        #expect(runAway.effectChanges.isEmpty)
    }

    @Test func selectRecklessByName() async throws {
        let reckless = try await Ability.selectOne(by: "reckless")
        #expect(reckless.id == 120)
        #expect(reckless.name.lowercased() == "reckless")
        #expect(reckless.isMainSeries)
        #expect(reckless.generation.name == "generation-iv")
        #expect(reckless.pokemon.contains(where: { $0.pokemon.name == "rhyhorn" }))
        #expect(reckless.effectEntries.contains(where: { $0.effect == "This Pokémon's recoil moves and crash moves have 1.2× their base power.\n\nstruggle is unaffected.\n\nThe \"crash moves\" are the moves that damage the user upon missing: jump kick and high jump kick." }))
        #expect(reckless.flavorTextEntries.contains(where: { $0.flavorText == "Powers up moves that\nhave recoil damage." }))
        // At this point, PokeAPI return an empty array
        #expect(reckless.effectChanges.isEmpty)
    }

    @Test func selectMimicryByName() async throws {
        let mimicry = try await Ability.selectOne(by: "mimicry")
        #expect(mimicry.id == 250)
        #expect(mimicry.name.lowercased() == "mimicry")
        #expect(mimicry.isMainSeries)
        #expect(mimicry.generation.name == "generation-viii")
        #expect(mimicry.pokemon.contains(where: { $0.pokemon.name == "stunfisk-galar" }))
        #expect(mimicry.effectEntries.contains(where: { $0.effect == "Changes the Pokémon’s type depending on the terrain." }))
        // At this point, PokeAPI return an empty array
        #expect(mimicry.effectChanges.isEmpty)
    }

    @Test func selectSupersweetSyrupByName() async throws {
        let supersweetSyrup = try await Ability.selectOne(by: "supersweet-syrup")
        #expect(supersweetSyrup.id == 300)
        #expect(supersweetSyrup.name.lowercased() == "supersweet-syrup")
        #expect(supersweetSyrup.isMainSeries)
        #expect(supersweetSyrup.generation.name == "generation-ix")
        #expect(supersweetSyrup.pokemon.contains(where: { $0.pokemon.name == "dipplin" }))
        #expect(supersweetSyrup.effectEntries.contains(where: { $0.effect == "A sickly sweet scent spreads across the field the first time the Pokémon enters a battle, lowering the evasiveness of opposing Pokémon." }))
        #expect(supersweetSyrup.flavorTextEntries.contains(where: { $0.flavorText == "Lowers the evasion of opposing Pokémon by 1 stage when first sent into battle" }))
        // At this point, PokeAPI return an empty array
        #expect(supersweetSyrup.effectChanges.isEmpty)
    }

    // MARK: - Random

    @Test func optionalOnRandomAbility() async throws {
        let randomID = Int.random(in: 1 ... 300)
        PokeLogger.info("Ability ID: \(randomID)")
        _ = try await Ability.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func fetchInexistingAbility() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await Ability.selectOne(by: "unknown")
        })
    }
}
