//
//  PokemonTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 01/03/2025.
//

@testable import PokeAPIService
import Testing

struct PokemonTest {
    // MARK: - Base Resources

    @Test func fecthBaseResources() async throws {
        let lightResources = try await Pokemon.lightResources(from: 0, count: 60)
        #expect(lightResources.count == 60)
        #expect(lightResources.last?.id == "60")
        #expect(lightResources.first?.id == "1")
        #expect(lightResources.first?.name == "bulbasaur")
        #expect(lightResources.first?.type == "pokemon")
    }

    @Test func fecthPaginatedBaseResources() async throws {
        let lightResources = try await Pokemon.lightResources(from: 60, count: 60)
        #expect(lightResources.count == 60)
        #expect(lightResources.last?.id == "120")
        #expect(lightResources.first?.id == "61")
        #expect(lightResources.first?.name == "poliwhirl")
        #expect(lightResources.first?.type == "pokemon")
    }

    // MARK: - Select All

    @Test func selectDefaultGroupOfPokemon() async throws {
        let group = try await Pokemon.selectAll()
        #expect(group.count == 20)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "bulbasaur")
        #expect(group.last?.id == 20)
        #expect(group.last?.name.lowercased() == "raticate")
    }

    @Test func selectLimitedGroupOfPokemon() async throws {
        let group = try await Pokemon.selectAll(count: 151)
        #expect(group.count == 151)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "bulbasaur")
        #expect(group.last?.id == 151)
        #expect(group.last?.name.lowercased() == "mew")
    }

    @Test func selectPaginatedGroupOfPokemon() async throws {
        let group = try await Pokemon.selectAll(from: 151, count: 100)
        #expect(group.count == 100)
        #expect(group.first?.id == 152)
        #expect(group.first?.name.lowercased() == "chikorita")
        #expect(group.last?.id == 251)
        #expect(group.last?.name.lowercased() == "celebi")
    }

    // MARK: - Select One By ID

    @Test func selectBulbasaurByID() async throws {
        let bulbasaur = try await Pokemon.selectOne(by: 1)
        #expect(bulbasaur.id == 1)
        #expect(bulbasaur.name.lowercased() == "bulbasaur")
        #expect(bulbasaur.types.contains(where: { $0.type.name == "grass" }))
        #expect(bulbasaur.types.contains(where: { $0.type.name == "poison" }))
        #expect(bulbasaur.gameIndices.contains(where: { $0.version.name == "red" }))
        #expect(bulbasaur.gameIndices.contains(where: { $0.version.name == "blue" }))
        #expect(bulbasaur.gameIndices.contains(where: { $0.version.name == "yellow" }))
        #expect(bulbasaur.sprites.versions.generationI.redBlue.frontDefault != nil)
        #expect(bulbasaur.sprites.versions.generationI.yellow.frontDefault != nil)
        #expect(!bulbasaur.sprites.frontDefault.isEmpty)
    }

    @Test func selectPikachuByID() async throws {
        let pikachu = try await Pokemon.selectOne(by: 25)
        #expect(pikachu.id == 25)
        #expect(pikachu.name.lowercased() == "pikachu")
        #expect(pikachu.types.contains(where: { $0.type.name == "electric" }))
        #expect(pikachu.gameIndices.contains(where: { $0.version.name == "red" }))
        #expect(pikachu.gameIndices.contains(where: { $0.version.name == "blue" }))
        #expect(pikachu.gameIndices.contains(where: { $0.version.name == "yellow" }))
        #expect(pikachu.sprites.versions.generationI.redBlue.frontDefault != nil)
        #expect(pikachu.sprites.versions.generationI.yellow.frontDefault != nil)
        #expect(!pikachu.sprites.frontDefault.isEmpty)
    }

    @Test func selectHoOhByID() async throws {
        let cyndaquil = try await Pokemon.selectOne(by: 250)
        #expect(cyndaquil.id == 250)
        #expect(cyndaquil.name.lowercased() == "ho-oh")
        #expect(cyndaquil.types.contains(where: { $0.type.name == "fire" }))
        #expect(cyndaquil.gameIndices.contains(where: { $0.version.name == "gold" }))
        #expect(cyndaquil.gameIndices.contains(where: { $0.version.name == "silver" }))
        #expect(cyndaquil.gameIndices.contains(where: { $0.version.name == "crystal" }))
        #expect(cyndaquil.sprites.versions.generationII.gold.frontDefault != nil)
        #expect(cyndaquil.sprites.versions.generationII.silver.frontDefault != nil)
        #expect(cyndaquil.sprites.versions.generationII.crystal.frontDefault != nil)
        #expect(!cyndaquil.sprites.frontDefault.isEmpty)
    }

    @Test func selectRayquazaByID() async throws {
        let rayquaza = try await Pokemon.selectOne(by: 384)
        #expect(rayquaza.id == 384)
        #expect(rayquaza.name.lowercased() == "rayquaza")
        #expect(rayquaza.types.contains(where: { $0.type.name == "dragon" }))
        #expect(rayquaza.gameIndices.contains(where: { $0.version.name == "ruby" }))
        #expect(rayquaza.gameIndices.contains(where: { $0.version.name == "sapphire" }))
        #expect(rayquaza.gameIndices.contains(where: { $0.version.name == "emerald" }))
        #expect(rayquaza.sprites.versions.generationIII.rubySapphire.frontDefault != nil)
        #expect(rayquaza.sprites.versions.generationIII.fireredLeafgreen.frontDefault == nil)
        #expect(rayquaza.sprites.versions.generationIII.emerald.frontDefault != nil)
        #expect(!rayquaza.sprites.frontDefault.isEmpty)
    }

    @Test func selectSolgaleoByID() async throws {
        let solgaleo = try await Pokemon.selectOne(by: 791)
        #expect(solgaleo.id == 791)
        #expect(solgaleo.name.lowercased() == "solgaleo")
        #expect(solgaleo.types.contains(where: { $0.type.name == "psychic" }))
        // At this point, PokeAPI return an empty array for this pokemon
        #expect(solgaleo.gameIndices.isEmpty)
        #expect(solgaleo.sprites.versions.generationVII.ultraSunUltraMoon.frontDefault != nil)
        #expect(!solgaleo.sprites.frontDefault.isEmpty)
    }

    // MARK: - Select One By Name

    @Test func selectBulbasaurByName() async throws {
        let bulbasaur = try await Pokemon.selectOne(by: "bulbasaur")
        #expect(bulbasaur.id == 1)
        #expect(bulbasaur.name.lowercased() == "bulbasaur")
        #expect(bulbasaur.types.contains(where: { $0.type.name == "grass" }))
        #expect(bulbasaur.types.contains(where: { $0.type.name == "poison" }))
        #expect(bulbasaur.gameIndices.contains(where: { $0.version.name == "red" }))
        #expect(bulbasaur.gameIndices.contains(where: { $0.version.name == "blue" }))
        #expect(bulbasaur.gameIndices.contains(where: { $0.version.name == "yellow" }))
        #expect(bulbasaur.sprites.versions.generationI.redBlue.frontDefault != nil)
        #expect(bulbasaur.sprites.versions.generationI.yellow.frontDefault != nil)
        #expect(!bulbasaur.sprites.frontDefault.isEmpty)
    }

    @Test func selectPikachuByName() async throws {
        let pikachu = try await Pokemon.selectOne(by: "pikachu")
        #expect(pikachu.id == 25)
        #expect(pikachu.name.lowercased() == "pikachu")
        #expect(pikachu.types.contains(where: { $0.type.name == "electric" }))
        #expect(pikachu.gameIndices.contains(where: { $0.version.name == "red" }))
        #expect(pikachu.gameIndices.contains(where: { $0.version.name == "blue" }))
        #expect(pikachu.gameIndices.contains(where: { $0.version.name == "yellow" }))
        #expect(pikachu.sprites.versions.generationI.redBlue.frontDefault != nil)
        #expect(pikachu.sprites.versions.generationI.yellow.frontDefault != nil)
        #expect(!pikachu.sprites.frontDefault.isEmpty)
    }

    @Test func selectHoOhByName() async throws {
        let cyndaquil = try await Pokemon.selectOne(by: "ho-oh")
        #expect(cyndaquil.id == 250)
        #expect(cyndaquil.name.lowercased() == "ho-oh")
        #expect(cyndaquil.types.contains(where: { $0.type.name == "fire" }))
        #expect(cyndaquil.gameIndices.contains(where: { $0.version.name == "gold" }))
        #expect(cyndaquil.gameIndices.contains(where: { $0.version.name == "silver" }))
        #expect(cyndaquil.gameIndices.contains(where: { $0.version.name == "crystal" }))
        #expect(cyndaquil.sprites.versions.generationII.gold.frontDefault != nil)
        #expect(cyndaquil.sprites.versions.generationII.silver.frontDefault != nil)
        #expect(cyndaquil.sprites.versions.generationII.crystal.frontDefault != nil)
        #expect(!cyndaquil.sprites.frontDefault.isEmpty)
    }

    @Test func selectRayquazaByName() async throws {
        let rayquaza = try await Pokemon.selectOne(by: "rayquaza")
        #expect(rayquaza.id == 384)
        #expect(rayquaza.name.lowercased() == "rayquaza")
        #expect(rayquaza.types.contains(where: { $0.type.name == "dragon" }))
        #expect(rayquaza.gameIndices.contains(where: { $0.version.name == "ruby" }))
        #expect(rayquaza.gameIndices.contains(where: { $0.version.name == "sapphire" }))
        #expect(rayquaza.gameIndices.contains(where: { $0.version.name == "emerald" }))
        #expect(rayquaza.sprites.versions.generationIII.rubySapphire.frontDefault != nil)
        #expect(rayquaza.sprites.versions.generationIII.fireredLeafgreen.frontDefault == nil)
        #expect(rayquaza.sprites.versions.generationIII.emerald.frontDefault != nil)
        #expect(!rayquaza.sprites.frontDefault.isEmpty)
    }

    @Test func selectSolgaleoByName() async throws {
        let solgaleo = try await Pokemon.selectOne(by: "solgaleo")
        #expect(solgaleo.id == 791)
        #expect(solgaleo.name.lowercased() == "solgaleo")
        #expect(solgaleo.types.contains(where: { $0.type.name == "psychic" }))
        // At this point, PokeAPI return an empty array for this pokemon
        #expect(solgaleo.gameIndices.isEmpty)
        #expect(solgaleo.sprites.versions.generationVII.ultraSunUltraMoon.frontDefault != nil)
        #expect(!solgaleo.sprites.frontDefault.isEmpty)
    }

    // MARK: - Random

    @Test func optionalOnRandomPokemon() async throws {
        let randomID = Int.random(in: 1 ... 1025)
        PokeLogger.info("Pokemon ID: \(randomID)")
        _ = try await Pokemon.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func fetchInexistingPokemon() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await Pokemon.selectOne(by: "unknown")
        })
    }
}
