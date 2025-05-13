//
//  BerryFlavorTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 13/04/2025.
//

@testable import PokeAPIService
import Testing

struct BerryFlavorTest {
    // MARK: - Base Resources

    @Test func fecthBaseResources() async throws {
        let lightResources = try await BerryFlavor.lightResources(from: 0, count: 2)
        #expect(lightResources.count == 2)
        #expect(lightResources.first?.id == "1")
        #expect(lightResources.first?.name == "spicy")
        #expect(lightResources.first?.type == "berry-flavor")
        #expect(lightResources.last?.id == "2")
        #expect(lightResources.last?.name == "dry")
        #expect(lightResources.last?.type == "berry-flavor")
    }

    @Test func fecthPaginatedBaseResources() async throws {
        let lightResources = try await BerryFlavor.lightResources(from: 2, count: 3)
        #expect(lightResources.count == 3)
        #expect(lightResources.first?.id == "3")
        #expect(lightResources.first?.name == "sweet")
        #expect(lightResources.first?.type == "berry-flavor")
        #expect(lightResources.last?.id == "5")
        #expect(lightResources.last?.name == "sour")
        #expect(lightResources.last?.type == "berry-flavor")
    }

    // MARK: - Select All

    @Test func selectDefaultGroupOfPokedex() async throws {
        let group = try await BerryFlavor.selectAll()
        #expect(group.count == 5)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "spicy")
        #expect(group.last?.id == 5)
        #expect(group.last?.name.lowercased() == "sour")
    }

    @Test func selectLimitedGroupOfPokedex() async throws {
        let group = try await BerryFlavor.selectAll(count: 3)
        #expect(group.count == 3)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "spicy")
        #expect(group.last?.id == 3)
        #expect(group.last?.name.lowercased() == "sweet")
    }

    @Test func selectPaginatedGroupOfPokedex() async throws {
        let group = try await BerryFlavor.selectAll(from: 3, count: 2)
        #expect(group.count == 2)
        #expect(group.first?.id == 4)
        #expect(group.first?.name.lowercased() == "bitter")
        #expect(group.last?.id == 5)
        #expect(group.last?.name.lowercased() == "sour")
    }

    // MARK: - Select One By ID

    @Test func selectSpicyByID() async throws {
        let flavor = try await BerryFlavor.selectOne(by: 1)
        #expect(flavor.id == 1)
        #expect(flavor.name.lowercased() == "spicy")
        #expect(flavor.berries.contains(where: { $0.berry.name.lowercased() == "belue" }))
        #expect(flavor.berries.contains(where: { $0.berry.name.lowercased() == "tamato" }))
        #expect(flavor.contestType.name == "cool")
    }

    @Test func selectSweetByID() async throws {
        let flavor = try await BerryFlavor.selectOne(by: 3)
        #expect(flavor.id == 3)
        #expect(flavor.name.lowercased() == "sweet")
        #expect(flavor.berries.contains(where: { $0.berry.name.lowercased() == "occa" }))
        #expect(flavor.berries.contains(where: { $0.berry.name.lowercased() == "ganlon" }))
        #expect(flavor.contestType.name == "cute")
    }

    @Test func selectSourByID() async throws {
        let flavor = try await BerryFlavor.selectOne(by: 5)
        #expect(flavor.id == 5)
        #expect(flavor.name.lowercased() == "sour")
        #expect(flavor.berries.contains(where: { $0.berry.name.lowercased() == "sitrus" }))
        #expect(flavor.berries.contains(where: { $0.berry.name.lowercased() == "petaya" }))
        #expect(flavor.contestType.name == "tough")
    }

    // MARK: - Select One By Name

    @Test func selectSpicyByName() async throws {
        let flavor = try await BerryFlavor.selectOne(by: "spicy")
        #expect(flavor.id == 1)
        #expect(flavor.name.lowercased() == "spicy")
        #expect(flavor.berries.contains(where: { $0.berry.name.lowercased() == "belue" }))
        #expect(flavor.berries.contains(where: { $0.berry.name.lowercased() == "tamato" }))
        #expect(flavor.contestType.name == "cool")
    }

    @Test func selectSweetByName() async throws {
        let flavor = try await BerryFlavor.selectOne(by: "sweet")
        #expect(flavor.id == 3)
        #expect(flavor.name.lowercased() == "sweet")
        #expect(flavor.berries.contains(where: { $0.berry.name.lowercased() == "occa" }))
        #expect(flavor.berries.contains(where: { $0.berry.name.lowercased() == "ganlon" }))
        #expect(flavor.contestType.name == "cute")
    }

    @Test func selectSourByName() async throws {
        let flavor = try await BerryFlavor.selectOne(by: "sour")
        #expect(flavor.id == 5)
        #expect(flavor.name.lowercased() == "sour")
        #expect(flavor.berries.contains(where: { $0.berry.name.lowercased() == "sitrus" }))
        #expect(flavor.berries.contains(where: { $0.berry.name.lowercased() == "petaya" }))
        #expect(flavor.contestType.name == "tough")
    }

    // MARK: - Random

    @Test func optionalOnRandomBerryFlavor() async throws {
        let randomID = Int.random(in: 1 ... 5)
        PokeLogger.info("Select BerryFlavor ID: \(randomID)")
        _ = try await BerryFlavor.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func selectInexistingBerryFlavor() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await BerryFlavor.selectOne(by: "unknown")
        })
    }
}
