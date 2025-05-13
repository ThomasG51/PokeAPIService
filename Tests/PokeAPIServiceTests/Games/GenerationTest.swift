//
//  GenerationTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 12/04/2025.
//

@testable import PokeAPIService
import Testing

struct GenerationTest {
    // MARK: - Base Resources

    @Test func fecthBaseResources() async throws {
        let lightResources = try await Generation.lightResources(from: 0, count: 3)
        #expect(lightResources.count == 3)
        #expect(lightResources.last?.id == "3")
        #expect(lightResources.first?.id == "1")
        #expect(lightResources.first?.name == "generation-i")
        #expect(lightResources.first?.type == "generation")
    }

    @Test func fecthPaginatedBaseResources() async throws {
        let lightResources = try await Generation.lightResources(from: 3, count: 3)
        #expect(lightResources.count == 3)
        #expect(lightResources.last?.id == "6")
        #expect(lightResources.first?.id == "4")
        #expect(lightResources.first?.name == "generation-iv")
        #expect(lightResources.first?.type == "generation")
    }

    // MARK: - Select All

    @Test func selectDefaultGroupOfGeneration() async throws {
        let group = try await Generation.selectAll()
        #expect(group.count == 9)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "generation-i")
        #expect(group.last?.id == 9)
        #expect(group.last?.name.lowercased() == "generation-ix")
    }

    @Test func selectLimitedGroupOfGeneration() async throws {
        let group = try await Generation.selectAll(count: 3)
        #expect(group.count == 3)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "generation-i")
        #expect(group.last?.id == 3)
        #expect(group.last?.name.lowercased() == "generation-iii")
    }

    @Test func selectPaginatedGroupOfGeneration() async throws {
        let group = try await Generation.selectAll(from: 3, count: 3)
        #expect(group.count == 3)
        #expect(group.first?.id == 4)
        #expect(group.first?.name.lowercased() == "generation-iv")
        #expect(group.last?.id == 6)
        #expect(group.last?.name.lowercased() == "generation-vi")
    }

    // MARK: - Select One By ID

    @Test func selectGenerationIByID() async throws {
        let generationI = try await Generation.selectOne(by: 1)
        #expect(generationI.id == 1)
        #expect(generationI.name == "generation-i")
        #expect(generationI.mainRegion.name == "kanto")
        #expect(generationI.pokemonSpecies.count == 151)
        #expect(generationI.versionGroups.contains(where: { $0.name == "red-blue" }))
        #expect(generationI.versionGroups.contains(where: { $0.name == "yellow" }))
    }

    @Test func selectGenerationIIByID() async throws {
        let generationII = try await Generation.selectOne(by: 2)
        #expect(generationII.id == 2)
        #expect(generationII.name == "generation-ii")
        #expect(generationII.mainRegion.name == "johto")
        #expect(generationII.pokemonSpecies.count == 100)
        #expect(generationII.versionGroups.contains(where: { $0.name == "gold-silver" }))
        #expect(generationII.versionGroups.contains(where: { $0.name == "crystal" }))
    }

    @Test func selectGenerationVByID() async throws {
        let generationV = try await Generation.selectOne(by: 5)
        #expect(generationV.id == 5)
        #expect(generationV.name == "generation-v")
        #expect(generationV.mainRegion.name == "unova")
        #expect(generationV.pokemonSpecies.count == 156)
        #expect(generationV.versionGroups.contains(where: { $0.name == "black-white" }))
    }

    @Test func selectGenerationVIIByID() async throws {
        let generationI = try await Generation.selectOne(by: 7)
        #expect(generationI.id == 7)
        #expect(generationI.name == "generation-vii")
        #expect(generationI.mainRegion.name == "alola")
        #expect(generationI.pokemonSpecies.count == 88)
        #expect(generationI.versionGroups.contains(where: { $0.name == "sun-moon" }))
        #expect(generationI.versionGroups.contains(where: { $0.name == "ultra-sun-ultra-moon" }))
    }

    // MARK: - Select One By Name

    @Test func selectGenerationIByName() async throws {
        let generationI = try await Generation.selectOne(by: "generation-i")
        #expect(generationI.id == 1)
        #expect(generationI.name == "generation-i")
        #expect(generationI.mainRegion.name == "kanto")
        #expect(generationI.pokemonSpecies.count == 151)
        #expect(generationI.versionGroups.contains(where: { $0.name == "red-blue" }))
        #expect(generationI.versionGroups.contains(where: { $0.name == "yellow" }))
    }

    @Test func selectGenerationIIByName() async throws {
        let generationII = try await Generation.selectOne(by: "generation-ii")
        #expect(generationII.id == 2)
        #expect(generationII.name == "generation-ii")
        #expect(generationII.mainRegion.name == "johto")
        #expect(generationII.pokemonSpecies.count == 100)
        #expect(generationII.versionGroups.contains(where: { $0.name == "gold-silver" }))
        #expect(generationII.versionGroups.contains(where: { $0.name == "crystal" }))
    }

    @Test func selectGenerationVByName() async throws {
        let generationV = try await Generation.selectOne(by: "generation-v")
        #expect(generationV.id == 5)
        #expect(generationV.name == "generation-v")
        #expect(generationV.mainRegion.name == "unova")
        #expect(generationV.pokemonSpecies.count == 156)
        #expect(generationV.versionGroups.contains(where: { $0.name == "black-white" }))
    }

    @Test func selectGenerationVIIByName() async throws {
        let generationI = try await Generation.selectOne(by: "generation-vii")
        #expect(generationI.id == 7)
        #expect(generationI.name == "generation-vii")
        #expect(generationI.mainRegion.name == "alola")
        #expect(generationI.pokemonSpecies.count == 88)
        #expect(generationI.versionGroups.contains(where: { $0.name == "sun-moon" }))
        #expect(generationI.versionGroups.contains(where: { $0.name == "ultra-sun-ultra-moon" }))
    }

    // MARK: - Random

    @Test func optionalOnRandomGeneration() async throws {
        let randomID = Int.random(in: 1 ... 9)
        PokeLogger.info("Select Generation ID: \(randomID)")
        _ = try await Generation.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func selectInexistingGeneration() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await Generation.selectOne(by: "unknown")
        })
    }
}
