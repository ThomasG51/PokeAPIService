//
//  PokedexTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 12/04/2025.
//

@testable import PokeAPIService
import Testing

struct PokedexTest {
    @Test func testPokedexBaseResourceWithPagination() async throws {
        let firstBaseResources = try await Pokedex.baseResources(from: 0, count: 3)
        #expect(firstBaseResources.count == 3)
        #expect(firstBaseResources.first?.id == "1")
        #expect(firstBaseResources.first?.name == "national")
        #expect(firstBaseResources.first?.type == "pokedex")
        #expect(firstBaseResources.last?.id == "3")
        #expect(firstBaseResources.last?.name == "original-johto")
        #expect(firstBaseResources.last?.type == "pokedex")
    }
    
    @Test func testPokedexSelectAll() async throws {
        let generations = try await Pokedex.selectAll()
        #expect(generations.count == 20)
    }
    
    @Test func testPokedexSelectNationalByID() async throws {
        let nationalPokedex = try await Pokedex.selectOne(by: 1)
        #expect(nationalPokedex.id == 1)
        #expect(nationalPokedex.name == "national")
        #expect(nationalPokedex.isMainSeries == true)
        #expect(nationalPokedex.pokemonEntries.count == 1025)
        #expect(nationalPokedex.descriptions.first { $0.language.name == "en" }?.description == "Entire National dex")
    }
    
    @Test func testPokedexSelectNationalByName() async throws {
        let nationalPokedex = try await Pokedex.selectOne(by: "national")
        #expect(nationalPokedex.id == 1)
        #expect(nationalPokedex.name == "national")
        #expect(nationalPokedex.isMainSeries == true)
        #expect(nationalPokedex.pokemonEntries.count == 1025)
        #expect(nationalPokedex.descriptions.first { $0.language.name == "en" }?.description == "Entire National dex")
    }
    
    @Test func testPokedexSelectKantoByID() async throws {
        let kantoPokedex = try await Pokedex.selectOne(by: 2)
        #expect(kantoPokedex.id == 2)
        #expect(kantoPokedex.name == "kanto")
        #expect(kantoPokedex.isMainSeries == true)
        #expect(kantoPokedex.pokemonEntries.count == 151)
        #expect(kantoPokedex.descriptions.first { $0.language.name == "en" }?.description == "Red/Blue/Yellow Kanto dex")
    }
    
    @Test func testPokedexSelectKantoByName() async throws {
        let kantoPokedex = try await Pokedex.selectOne(by: "kanto")
        #expect(kantoPokedex.id == 2)
        #expect(kantoPokedex.name == "kanto")
        #expect(kantoPokedex.isMainSeries == true)
        #expect(kantoPokedex.pokemonEntries.count == 151)
        #expect(kantoPokedex.descriptions.first { $0.language.name == "en" }?.description == "Red/Blue/Yellow Kanto dex")
    }
    
    @Test func testFetchInexistingPokedex() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await Pokedex.selectOne(by: "unknown")
        })
    }
}
