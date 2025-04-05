//
//  PokemonTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 01/03/2025.
//

@testable import PokeAPIService
import Testing

struct PokemonTest {
    @Test func testBaseResourcesWithPagination() async throws {
        let firstBaseResources = try await Pokemon.baseResources(from: 0, count: 60)
        #expect(firstBaseResources.count == 60)
        #expect(firstBaseResources.last?.id == "60")
        #expect(firstBaseResources.first?.id == "1")
        #expect(firstBaseResources.first?.name == "bulbasaur")
        #expect(firstBaseResources.first?.type == "pokemon")

        let secondBaseResources = try await Pokemon.baseResources(from: 60, count: 60)
        #expect(secondBaseResources.count == 60)
        #expect(secondBaseResources.last?.id == "120")
        #expect(secondBaseResources.first?.id == "61")
        #expect(secondBaseResources.first?.name == "poliwhirl")
        #expect(secondBaseResources.first?.type == "pokemon")
    }

    @Test func testSelectFirstGenerationOfPokemon() async throws {
        let firstGeneration = try await Pokemon.selectAll(count: 151)
        #expect(firstGeneration.count == 151)
        #expect(firstGeneration.first?.id == 1)
        #expect(firstGeneration.first?.name.lowercased() == "bulbasaur")
        #expect(firstGeneration.last?.id == 151)
        #expect(firstGeneration.last?.name.lowercased() == "mew")
    }

    @Test func testSelectSecondGenerationOfPokemon() async throws {
        let secondGeneration = try await Pokemon.selectAll(from: 151, count: 100)
        #expect(secondGeneration.count == 100)
        #expect(secondGeneration.first?.id == 152)
        #expect(secondGeneration.first?.name.lowercased() == "chikorita")
        #expect(secondGeneration.last?.id == 251)
        #expect(secondGeneration.last?.name.lowercased() == "celebi")
    }

    @Test func testFetchBulbasaurByID() async throws {
        let bulbasaur = try await Pokemon.selectOne(by: 1)
        #expect(bulbasaur.id == 1)
        #expect(bulbasaur.name.lowercased() == "bulbasaur")
        #expect(bulbasaur.types.contains(where: { $0.type.name == "grass" }))
        #expect(bulbasaur.types.contains(where: { $0.type.name == "poison" }))
        #expect(!bulbasaur.sprites.frontDefault.isEmpty)
        #expect(!bulbasaur.sprites.backDefault.isEmpty)
        #expect(bulbasaur.gameIndices.contains(where: { $0.version.name == "blue" }))
    }

    @Test func testFetchBulbasaurByName() async throws {
        let bulbasaur = try await Pokemon.selectOne(by: "bulbasaur")
        #expect(bulbasaur.id == 1)
        #expect(bulbasaur.name.lowercased() == "bulbasaur")
        #expect(bulbasaur.types.contains(where: { $0.type.name == "grass" }))
        #expect(bulbasaur.types.contains(where: { $0.type.name == "poison" }))
        #expect(!bulbasaur.sprites.frontDefault.isEmpty)
        #expect(!bulbasaur.sprites.backDefault.isEmpty)
        #expect(bulbasaur.gameIndices.contains(where: { $0.version.name == "blue" }))
    }

    @Test func testFetchPikachuByID() async throws {
        let pikachu = try await Pokemon.selectOne(by: 25)
        #expect(pikachu.id == 25)
        #expect(pikachu.name.lowercased() == "pikachu")
        #expect(pikachu.types.contains(where: { $0.type.name == "electric" }))
        #expect(!pikachu.sprites.frontDefault.isEmpty)
        #expect(!pikachu.sprites.backDefault.isEmpty)
        #expect(pikachu.gameIndices.contains(where: { $0.version.name == "yellow" }))
    }

    @Test func testFetchPikachuByName() async throws {
        let pikachu = try await Pokemon.selectOne(by: "pikachu")
        #expect(pikachu.id == 25)
        #expect(pikachu.name.lowercased() == "pikachu")
        #expect(pikachu.types.contains(where: { $0.type.name == "electric" }))
        #expect(!pikachu.sprites.frontDefault.isEmpty)
        #expect(!pikachu.sprites.backDefault.isEmpty)
        #expect(pikachu.gameIndices.contains(where: { $0.version.name == "yellow" }))
    }

    @Test func testFetchInexistingPokemon() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await Pokemon.selectOne(by: "unknown")
        })
    }
}
