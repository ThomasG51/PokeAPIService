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

    @Test func testFecthBaseResources() async throws {
        let baseResources = try await Pokedex.baseResources(from: 0, count: 3)
        #expect(baseResources.count == 3)
        #expect(baseResources.first?.id == "1")
        #expect(baseResources.first?.name == "national")
        #expect(baseResources.first?.type == "pokedex")
        #expect(baseResources.last?.id == "3")
        #expect(baseResources.last?.name == "original-johto")
        #expect(baseResources.last?.type == "pokedex")
    }

    @Test func testFecthPaginatedBaseResources() async throws {
        let baseResources = try await Pokedex.baseResources(from: 3, count: 6)
        #expect(baseResources.count == 6)
        #expect(baseResources.first?.id == "4")
        #expect(baseResources.first?.name == "hoenn")
        #expect(baseResources.first?.type == "pokedex")
        #expect(baseResources.last?.id == "9")
        #expect(baseResources.last?.name == "updated-unova")
        #expect(baseResources.last?.type == "pokedex")
    }

    // MARK: - Select All

    @Test func testSelectDefaultGroupOfPokedex() async throws {
        let group = try await Pokedex.selectAll()
        #expect(group.count == 20)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "national")
        #expect(group.last?.id == 21)
        #expect(group.last?.name.lowercased() == "updated-alola")
    }

    @Test func testSelectLimitedGroupOfPokedex() async throws {
        let group = try await Pokedex.selectAll(count: 3)
        #expect(group.count == 3)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "national")
        #expect(group.last?.id == 3)
        #expect(group.last?.name.lowercased() == "original-johto")
    }

    @Test func testSelectPaginatedGroupOfPokedex() async throws {
        let group = try await Pokedex.selectAll(from: 3, count: 3)
        #expect(group.count == 3)
        #expect(group.first?.id == 4)
        #expect(group.first?.name.lowercased() == "hoenn")
        #expect(group.last?.id == 6)
        #expect(group.last?.name.lowercased() == "extended-sinnoh")
    }

    // MARK: - Select One By ID

    @Test func testSelectNationalByID() async throws {
        let pokedex = try await Pokedex.selectOne(by: 1)
        #expect(pokedex.id == 1)
        #expect(pokedex.name == "national")
        // National Pokedex has no related region
        #expect(pokedex.region?.name == nil)
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 1025)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Entire National dex")
    }

    @Test func testPokedexKantoByID() async throws {
        let pokedex = try await Pokedex.selectOne(by: 2)
        #expect(pokedex.id == 2)
        #expect(pokedex.name == "kanto")
        #expect(pokedex.region?.name == "kanto")
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 151)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Red/Blue/Yellow Kanto dex")
    }

    @Test func testPokedexJohtoByID() async throws {
        let pokedex = try await Pokedex.selectOne(by: 3)
        #expect(pokedex.id == 3)
        #expect(pokedex.name == "original-johto")
        #expect(pokedex.region?.name == "johto")
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 251)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Gold/Silver/Crystal Johto dex—called the \"New\" Pokédex in-game")
    }

    @Test func testPokedexSinnohByID() async throws {
        let pokedex = try await Pokedex.selectOne(by: 5)
        #expect(pokedex.id == 5)
        #expect(pokedex.name == "original-sinnoh")
        #expect(pokedex.region?.name == "sinnoh")
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 151)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Diamond/Pearl Sinnoh dex")
    }

    @Test func testPokedexAlolaByID() async throws {
        let pokedex = try await Pokedex.selectOne(by: 16)
        #expect(pokedex.id == 16)
        #expect(pokedex.name == "original-alola")
        #expect(pokedex.region?.name == "alola")
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 302)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Sun/Moon Alola dex")
    }

    // MARK: - Select One By Name

    @Test func testSelectNationalByName() async throws {
        let pokedex = try await Pokedex.selectOne(by: "national")
        #expect(pokedex.id == 1)
        #expect(pokedex.name == "national")
        // National Pokedex has no related region
        #expect(pokedex.region?.name == nil)
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 1025)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Entire National dex")
    }

    @Test func testPokedexKantoByName() async throws {
        let pokedex = try await Pokedex.selectOne(by: "kanto")
        #expect(pokedex.id == 2)
        #expect(pokedex.name == "kanto")
        #expect(pokedex.region?.name == "kanto")
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 151)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Red/Blue/Yellow Kanto dex")
    }

    @Test func testPokedexJohtoByName() async throws {
        let pokedex = try await Pokedex.selectOne(by: "original-johto")
        #expect(pokedex.id == 3)
        #expect(pokedex.name == "original-johto")
        #expect(pokedex.region?.name == "johto")
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 251)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Gold/Silver/Crystal Johto dex—called the \"New\" Pokédex in-game")
    }

    @Test func testPokedexSinnohByName() async throws {
        let pokedex = try await Pokedex.selectOne(by: "original-sinnoh")
        #expect(pokedex.id == 5)
        #expect(pokedex.name == "original-sinnoh")
        #expect(pokedex.region?.name == "sinnoh")
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 151)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Diamond/Pearl Sinnoh dex")
    }

    @Test func testPokedexAlolaByName() async throws {
        let pokedex = try await Pokedex.selectOne(by: "original-alola")
        #expect(pokedex.id == 16)
        #expect(pokedex.name == "original-alola")
        #expect(pokedex.region?.name == "alola")
        #expect(pokedex.isMainSeries == true)
        #expect(pokedex.pokemonEntries.count == 302)
        #expect(pokedex.descriptions.first { $0.language.name == "en" }?.description == "Sun/Moon Alola dex")
    }

    // MARK: - Random

    @Test func testOptionalOnRandomPokedex() async throws {
        let randomID = Int.random(in: 1 ... 32)
        PokeLogger.info("Pokedex ID: \(randomID)")
        _ = try await Pokedex.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func testFetchInexistingPokedex() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await Pokedex.selectOne(by: "unknown")
        })
    }
}
