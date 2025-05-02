//
//  GenderTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 30/04/2025.
//

@testable import PokeAPIService
import Testing

struct GenderTest {
    // MARK: - Base Resources

    @Test func testFecthBaseResources() async throws {
        let lightResources = try await Gender.lightResources(from: 0, count: 2)
        #expect(lightResources.count == 2)
        #expect(lightResources.last?.id == "2")
        #expect(lightResources.first?.id == "1")
        #expect(lightResources.first?.name == "female")
        #expect(lightResources.first?.type == "gender")
    }

    @Test func testFecthPaginatedBaseResources() async throws {
        let lightResources = try await Gender.lightResources(from: 2, count: 1)
        #expect(lightResources.count == 1)
        #expect(lightResources.first?.id == "3")
        #expect(lightResources.first?.name == "genderless")
        #expect(lightResources.first?.type == "gender")
    }

    // MARK: - Select All

    @Test func testSelectDefaultGroupOfGender() async throws {
        let group = try await Gender.selectAll()
        #expect(group.count == 3)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "female")
        #expect(group.last?.id == 3)
        #expect(group.last?.name.lowercased() == "genderless")
    }

    @Test func testSelectLimitedGroupOfGender() async throws {
        let group = try await Gender.selectAll(count: 2)
        #expect(group.count == 2)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "female")
        #expect(group.last?.id == 2)
        #expect(group.last?.name.lowercased() == "male")
    }

    @Test func testSelectPaginatedGroupOfGender() async throws {
        let group = try await Gender.selectAll(from: 2, count: 1)
        #expect(group.count == 1)
        #expect(group.first?.id == 3)
        #expect(group.first?.name.lowercased() == "genderless")
    }

    // MARK: - Select One By ID

    @Test func testSelectFemaleByID() async throws {
        let female = try await Gender.selectOne(by: 1)
        #expect(female.id == 1)
        #expect(female.name.lowercased() == "female")
        #expect(!female.pokemonSpeciesDetails.isEmpty)
        #expect(!female.requiredForEvolution.isEmpty)
    }

    @Test func testSelectMaleByID() async throws {
        let male = try await Gender.selectOne(by: 2)
        #expect(male.id == 2)
        #expect(male.name.lowercased() == "male")
        #expect(!male.pokemonSpeciesDetails.isEmpty)
        #expect(!male.requiredForEvolution.isEmpty)
    }

    @Test func testSelectGenderlessByID() async throws {
        let genderless = try await Gender.selectOne(by: 3)
        #expect(genderless.id == 3)
        #expect(genderless.name.lowercased() == "genderless")
        #expect(!genderless.pokemonSpeciesDetails.isEmpty)
        #expect(genderless.requiredForEvolution.isEmpty)
    }

    // MARK: - Select One By Name

    @Test func testSelectFemaleByName() async throws {
        let female = try await Gender.selectOne(by: "female")
        #expect(female.id == 1)
        #expect(female.name.lowercased() == "female")
        #expect(!female.pokemonSpeciesDetails.isEmpty)
        #expect(!female.requiredForEvolution.isEmpty)
    }

    @Test func testSelectMaleByName() async throws {
        let male = try await Gender.selectOne(by: "male")
        #expect(male.id == 2)
        #expect(male.name.lowercased() == "male")
        #expect(!male.pokemonSpeciesDetails.isEmpty)
        #expect(!male.requiredForEvolution.isEmpty)
    }

    @Test func testSelectGenderlessByName() async throws {
        let genderless = try await Gender.selectOne(by: "genderless")
        #expect(genderless.id == 3)
        #expect(genderless.name.lowercased() == "genderless")
        #expect(!genderless.pokemonSpeciesDetails.isEmpty)
        #expect(genderless.requiredForEvolution.isEmpty)
    }

    // MARK: - Random

    @Test func testOptionalOnRandomGender() async throws {
        let randomID = Int.random(in: 1 ... 3)
        PokeLogger.info("Gender ID: \(randomID)")
        _ = try await Gender.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func testFetchInexistingGender() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await Gender.selectOne(by: "unknown")
        })
    }
}
