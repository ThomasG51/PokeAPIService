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
    
    @Test func testFecthBaseResources() async throws {
        let baseResources = try await Generation.baseResources(from: 0, count: 3)
        #expect(baseResources.count == 3)
        #expect(baseResources.last?.id == "3")
        #expect(baseResources.first?.id == "1")
        #expect(baseResources.first?.name == "generation-i")
        #expect(baseResources.first?.type == "generation")
    }
    
    @Test func testFecthPaginatedBaseResources() async throws {
        let baseResources = try await Generation.baseResources(from: 3, count: 3)
        #expect(baseResources.count == 3)
        #expect(baseResources.last?.id == "6")
        #expect(baseResources.first?.id == "4")
        #expect(baseResources.first?.name == "generation-iv")
        #expect(baseResources.first?.type == "generation")
    }
    
    // MARK: - Select All
    
    @Test func testSelectDefaultGroupOfGeneration() async throws {
        let group = try await Generation.selectAll()
        #expect(group.count == 9)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "generation-i")
        #expect(group.last?.id == 9)
        #expect(group.last?.name.lowercased() == "generation-ix")
    }
    
    @Test func testSelectLimitedGroupOfGeneration() async throws {
        let group = try await Generation.selectAll(count: 3)
        #expect(group.count == 3)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "generation-i")
        #expect(group.last?.id == 3)
        #expect(group.last?.name.lowercased() == "generation-iii")
    }
    
    @Test func testSelectPaginatedGroupOfGeneration() async throws {
        let group = try await Generation.selectAll(from: 3, count: 3)
        #expect(group.count == 3)
        #expect(group.first?.id == 4)
        #expect(group.first?.name.lowercased() == "generation-iv")
        #expect(group.last?.id == 6)
        #expect(group.last?.name.lowercased() == "generation-vi")
    }
    
    // MARK: - Select One By ID
    
    @Test func testSelectGenerationIByID() async throws {
        let generationI = try await Generation.selectOne(by: 1)
        #expect(generationI.id == 1)
        #expect(generationI.name == "generation-i")
        #expect(generationI.mainRegion.name == "kanto")
        #expect(generationI.pokemonSpecies.count == 151)
        #expect(generationI.versionGroups.contains(where: { $0.name == "red-blue" }))
        #expect(generationI.versionGroups.contains(where: { $0.name == "yellow" }))
    }
    
    @Test func testSelectGenerationIIByID() async throws {
        let generationII = try await Generation.selectOne(by: 2)
        #expect(generationII.id == 2)
        #expect(generationII.name == "generation-ii")
        #expect(generationII.mainRegion.name == "johto")
        #expect(generationII.pokemonSpecies.count == 100)
        #expect(generationII.versionGroups.contains(where: { $0.name == "gold-silver" }))
        #expect(generationII.versionGroups.contains(where: { $0.name == "crystal" }))
    }
    
    @Test func testSelectGenerationVByID() async throws {
        let generationV = try await Generation.selectOne(by: 5)
        #expect(generationV.id == 5)
        #expect(generationV.name == "generation-v")
        #expect(generationV.mainRegion.name == "unova")
        #expect(generationV.pokemonSpecies.count == 156)
        #expect(generationV.versionGroups.contains(where: { $0.name == "black-white" }))
    }
    
    @Test func testSelectGenerationVIIByID() async throws {
        let generationI = try await Generation.selectOne(by: 7)
        #expect(generationI.id == 7)
        #expect(generationI.name == "generation-vii")
        #expect(generationI.mainRegion.name == "alola")
        #expect(generationI.pokemonSpecies.count == 88)
        #expect(generationI.versionGroups.contains(where: { $0.name == "sun-moon" }))
        #expect(generationI.versionGroups.contains(where: { $0.name == "ultra-sun-ultra-moon" }))
    }
    
    // MARK: - Select One By Name
    
    @Test func testSelectGenerationIByName() async throws {
        let generationI = try await Generation.selectOne(by: "generation-i")
        #expect(generationI.id == 1)
        #expect(generationI.name == "generation-i")
        #expect(generationI.mainRegion.name == "kanto")
        #expect(generationI.pokemonSpecies.count == 151)
        #expect(generationI.versionGroups.contains(where: { $0.name == "red-blue" }))
        #expect(generationI.versionGroups.contains(where: { $0.name == "yellow" }))
    }
    
    @Test func testSelectGenerationIIByName() async throws {
        let generationII = try await Generation.selectOne(by: "generation-ii")
        #expect(generationII.id == 2)
        #expect(generationII.name == "generation-ii")
        #expect(generationII.mainRegion.name == "johto")
        #expect(generationII.pokemonSpecies.count == 100)
        #expect(generationII.versionGroups.contains(where: { $0.name == "gold-silver" }))
        #expect(generationII.versionGroups.contains(where: { $0.name == "crystal" }))
    }
    
    @Test func testSelectGenerationVByName() async throws {
        let generationV = try await Generation.selectOne(by: "generation-v")
        #expect(generationV.id == 5)
        #expect(generationV.name == "generation-v")
        #expect(generationV.mainRegion.name == "unova")
        #expect(generationV.pokemonSpecies.count == 156)
        #expect(generationV.versionGroups.contains(where: { $0.name == "black-white" }))
    }
    
    @Test func testSelectGenerationVIIByName() async throws {
        let generationI = try await Generation.selectOne(by: "generation-vii")
        #expect(generationI.id == 7)
        #expect(generationI.name == "generation-vii")
        #expect(generationI.mainRegion.name == "alola")
        #expect(generationI.pokemonSpecies.count == 88)
        #expect(generationI.versionGroups.contains(where: { $0.name == "sun-moon" }))
        #expect(generationI.versionGroups.contains(where: { $0.name == "ultra-sun-ultra-moon" }))
    }
    
    // MARK: - Random
    
    @Test func testOptionalOnRandomGeneration() async throws {
        let randomID = Int.random(in: 1 ... 9)
        PokeLogger.info("Generation ID: \(randomID)")
        _ = try await Generation.selectOne(by: randomID)
    }
    
    // MARK: - Error

    @Test func testFetchInexistingGeneration() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await Generation.selectOne(by: "unknown")
        })
    }
}
