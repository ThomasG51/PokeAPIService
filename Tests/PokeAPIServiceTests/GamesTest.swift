//
//  GamesTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/03/2025.
//

@testable import PokeAPIService
import Testing

struct GamesTest {
    // MARK: - Generation

    @Test func testGenerationBaseResourceWithPagination() async throws {
        let firstBaseResources = try #require(await Generation.baseResources(from: 0, count: 3))
        #expect(firstBaseResources.count == 3)
        #expect(firstBaseResources.last?.id == "3")
        #expect(firstBaseResources.first?.id == "1")
        #expect(firstBaseResources.first?.name == "generation-i")
        #expect(firstBaseResources.first?.type == "generation")

        let secondBaseResources = try #require(await Generation.baseResources(from: 3, count: 3))
        #expect(secondBaseResources.count == 3)
        #expect(secondBaseResources.last?.id == "6")
        #expect(secondBaseResources.first?.id == "4")
        #expect(secondBaseResources.first?.name == "generation-iv")
        #expect(secondBaseResources.first?.type == "generation")
    }

    @Test func testGenerationSelectAll() async throws {
        let generations = try #require(await Generation.selectAll(count: 9))
        #expect(generations.count == 9)
    }

    @Test func testGenerationSelectFirstByID() async throws {
        let firstGeneration = try #require(await Generation.selectOne(by: 1))
        #expect(firstGeneration.id == 1)
        #expect(firstGeneration.name == "generation-i")
        #expect(firstGeneration.mainRegion.name == "kanto")
        #expect(firstGeneration.pokemonSpecies.count == 151)
        #expect(firstGeneration.versions.contains(where: { $0.name == "red-blue" }))
        #expect(firstGeneration.versions.contains(where: { $0.name == "yellow" }))
    }

    @Test func testGenerationSelectFirstByName() async throws {
        let firstGeneration = try #require(await Generation.selectOne(by: "generation-i"))
        #expect(firstGeneration.id == 1)
        #expect(firstGeneration.name == "generation-i")
        #expect(firstGeneration.mainRegion.name == "kanto")
        #expect(firstGeneration.pokemonSpecies.count == 151)
        #expect(firstGeneration.versions.contains(where: { $0.name == "red-blue" }))
        #expect(firstGeneration.versions.contains(where: { $0.name == "yellow" }))
    }

    @Test func testGenerationSelectSecondByID() async throws {
        let secondGeneration = try #require(await Generation.selectOne(by: 2))
        #expect(secondGeneration.id == 2)
        #expect(secondGeneration.name == "generation-ii")
        #expect(secondGeneration.mainRegion.name == "johto")
        #expect(secondGeneration.pokemonSpecies.count == 100)
        #expect(secondGeneration.versions.contains(where: { $0.name == "gold-silver" }))
        #expect(secondGeneration.versions.contains(where: { $0.name == "crystal" }))
    }

    @Test func testGenerationSelectSecondByName() async throws {
        let secondGeneration = try #require(await Generation.selectOne(by: "generation-ii"))
        #expect(secondGeneration.id == 2)
        #expect(secondGeneration.name == "generation-ii")
        #expect(secondGeneration.mainRegion.name == "johto")
        #expect(secondGeneration.pokemonSpecies.count == 100)
        #expect(secondGeneration.versions.contains(where: { $0.name == "gold-silver" }))
        #expect(secondGeneration.versions.contains(where: { $0.name == "crystal" }))
    }

    // MARK: - Pokedex

    @Test func testPokedexBaseResourceWithPagination() async throws {
        let firstBaseResources = try #require(await Pokedex.baseResources(from: 0, count: 3))
        #expect(firstBaseResources.count == 3)
        #expect(firstBaseResources.first?.id == "1")
        #expect(firstBaseResources.first?.name == "national")
        #expect(firstBaseResources.first?.type == "pokedex")
        #expect(firstBaseResources.last?.id == "3")
        #expect(firstBaseResources.last?.name == "original-johto")
        #expect(firstBaseResources.last?.type == "pokedex")
    }

    @Test func testPokedexSelectAll() async throws {
        let generations = try #require(await Pokedex.selectAll())
        #expect(generations.count == 20)
    }

    @Test func testPokedexSelectNationalByID() async throws {
        let nationalPokedex = try #require(await Pokedex.selectOne(by: 1))
        #expect(nationalPokedex.id == 1)
        #expect(nationalPokedex.name == "national")
        #expect(nationalPokedex.isMainSeries == true)
        #expect(nationalPokedex.pokemonEntries.count == 1025)
        #expect(nationalPokedex.descriptions.first { $0.language.name == "en" }?.description == "Entire National dex")
    }

    @Test func testPokedexSelectNationalByName() async throws {
        let nationalPokedex = try #require(await Pokedex.selectOne(by: "national"))
        #expect(nationalPokedex.id == 1)
        #expect(nationalPokedex.name == "national")
        #expect(nationalPokedex.isMainSeries == true)
        #expect(nationalPokedex.pokemonEntries.count == 1025)
        #expect(nationalPokedex.descriptions.first { $0.language.name == "en" }?.description == "Entire National dex")
    }

    @Test func testPokedexSelectKantoByID() async throws {
        let kantoPokedex = try #require(await Pokedex.selectOne(by: 2))
        #expect(kantoPokedex.id == 2)
        #expect(kantoPokedex.name == "kanto")
        #expect(kantoPokedex.isMainSeries == true)
        #expect(kantoPokedex.pokemonEntries.count == 151)
        #expect(kantoPokedex.descriptions.first { $0.language.name == "en" }?.description == "Red/Blue/Yellow Kanto dex")
    }

    @Test func testPokedexSelectKantoByName() async throws {
        let kantoPokedex = try #require(await Pokedex.selectOne(by: "kanto"))
        #expect(kantoPokedex.id == 2)
        #expect(kantoPokedex.name == "kanto")
        #expect(kantoPokedex.isMainSeries == true)
        #expect(kantoPokedex.pokemonEntries.count == 151)
        #expect(kantoPokedex.descriptions.first { $0.language.name == "en" }?.description == "Red/Blue/Yellow Kanto dex")
    }
}
