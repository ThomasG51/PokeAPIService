//
//  PokedexTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 12/04/2025.
//

@testable import PokeAPIService
import Testing

struct PokedexTest {
    // MARK: - Base Resources

    @Test func fecthBaseResources() async throws {
        let lightResources = try await Pokedex.lightResources(from: 0, count: 3)
        #expect(lightResources.count == 3)
        #expect(lightResources.first?.id == "1")
        #expect(lightResources.first?.name == "national")
        #expect(lightResources.first?.type == "pokedex")
        #expect(lightResources.last?.id == "3")
        #expect(lightResources.last?.name == "original-johto")
        #expect(lightResources.last?.type == "pokedex")
    }

    @Test func fecthPaginatedBaseResources() async throws {
        let lightResources = try await Pokedex.lightResources(from: 3, count: 6)
        #expect(lightResources.count == 6)
        #expect(lightResources.first?.id == "4")
        #expect(lightResources.first?.name == "hoenn")
        #expect(lightResources.first?.type == "pokedex")
        #expect(lightResources.last?.id == "9")
        #expect(lightResources.last?.name == "updated-unova")
        #expect(lightResources.last?.type == "pokedex")
    }

    // MARK: - Select All

    @Test func selectDefaultGroupOfPokedex() async throws {
        let group = try await Pokedex.selectAll()
        #expect(group.count == 20)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "national")
        #expect(group.last?.id == 21)
        #expect(group.last?.name.lowercased() == "updated-alola")
    }

    @Test func selectLimitedGroupOfPokedex() async throws {
        let group = try await Pokedex.selectAll(count: 3)
        #expect(group.count == 3)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "national")
        #expect(group.last?.id == 3)
        #expect(group.last?.name.lowercased() == "original-johto")
    }

    @Test func selectPaginatedGroupOfPokedex() async throws {
        let group = try await Pokedex.selectAll(from: 3, count: 3)
        #expect(group.count == 3)
        #expect(group.first?.id == 4)
        #expect(group.first?.name.lowercased() == "hoenn")
        #expect(group.last?.id == 6)
        #expect(group.last?.name.lowercased() == "extended-sinnoh")
    }

    // MARK: - Select One By ID

    @Test func selectNationalByID() async throws {
        let pokedex = try await Pokedex.selectOne(by: 1)
        #expect(pokedex.id == 1)
        #expect(pokedex.name == "national")
        // National Pokedex has no related region
        #expect(pokedex.region?.name == nil)
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 1025)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Entire National dex")
    }

    @Test func selectKantoByID() async throws {
        let pokedex = try await Pokedex.selectOne(by: 2)
        #expect(pokedex.id == 2)
        #expect(pokedex.name == "kanto")
        #expect(pokedex.region?.name == "kanto")
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 151)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Red/Blue/Yellow Kanto dex")
    }

    @Test func selectJohtoByID() async throws {
        let pokedex = try await Pokedex.selectOne(by: 3)
        #expect(pokedex.id == 3)
        #expect(pokedex.name == "original-johto")
        #expect(pokedex.region?.name == "johto")
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 251)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Gold/Silver/Crystal Johto dex—called the \"New\" Pokédex in-game")
    }

    @Test func selectSinnohByID() async throws {
        let pokedex = try await Pokedex.selectOne(by: 5)
        #expect(pokedex.id == 5)
        #expect(pokedex.name == "original-sinnoh")
        #expect(pokedex.region?.name == "sinnoh")
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 151)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Diamond/Pearl Sinnoh dex")
    }

    @Test func selectAlolaByID() async throws {
        let pokedex = try await Pokedex.selectOne(by: 16)
        #expect(pokedex.id == 16)
        #expect(pokedex.name == "original-alola")
        #expect(pokedex.region?.name == "alola")
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 302)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Sun/Moon Alola dex")
    }

    // MARK: - Select One By Name

    @Test func selectNationalByName() async throws {
        let pokedex = try await Pokedex.selectOne(by: "national")
        #expect(pokedex.id == 1)
        #expect(pokedex.name == "national")
        // National Pokedex has no related region
        #expect(pokedex.region?.name == nil)
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 1025)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Entire National dex")
    }

    @Test func selectKantoByName() async throws {
        let pokedex = try await Pokedex.selectOne(by: "kanto")
        #expect(pokedex.id == 2)
        #expect(pokedex.name == "kanto")
        #expect(pokedex.region?.name == "kanto")
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 151)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Red/Blue/Yellow Kanto dex")
    }

    @Test func selectJohtoByName() async throws {
        let pokedex = try await Pokedex.selectOne(by: "original-johto")
        #expect(pokedex.id == 3)
        #expect(pokedex.name == "original-johto")
        #expect(pokedex.region?.name == "johto")
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 251)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Gold/Silver/Crystal Johto dex—called the \"New\" Pokédex in-game")
    }

    @Test func selectSinnohByName() async throws {
        let pokedex = try await Pokedex.selectOne(by: "original-sinnoh")
        #expect(pokedex.id == 5)
        #expect(pokedex.name == "original-sinnoh")
        #expect(pokedex.region?.name == "sinnoh")
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 151)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Diamond/Pearl Sinnoh dex")
    }

    @Test func selectAlolaByName() async throws {
        let pokedex = try await Pokedex.selectOne(by: "original-alola")
        #expect(pokedex.id == 16)
        #expect(pokedex.name == "original-alola")
        #expect(pokedex.region?.name == "alola")
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 302)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Sun/Moon Alola dex")
    }

    // MARK: - Random

    @Test func optionalOnRandomPokedex() async throws {
        var randomID = Int.random(in: 1 ... 32)

        // Pokedex ID 10 does not exist
        while randomID == 10 {
            randomID = Int.random(in: 1 ... 32)
        }

        PokeLogger.info("Select Pokedex ID: \(randomID)")
        _ = try await Pokedex.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func selectInexistingPokedex() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await Pokedex.selectOne(by: "unknown")
        })
    }
}
