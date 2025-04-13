//
//  BerryFlavorTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 13/04/2025.
//

@testable import PokeAPIService
import Testing

struct BerryFlavorTest {
    @Test func testBaseResourcesWithPagination() async throws {
        let firstBaseResources = try await BerryFlavor.baseResources(from: 0, count: 2)
        #expect(firstBaseResources.count == 2)
        #expect(firstBaseResources.last?.id == "2")
        #expect(firstBaseResources.first?.id == "1")
        #expect(firstBaseResources.first?.name == "spicy")
        #expect(firstBaseResources.first?.type == "berry-flavor")

        let secondBaseResources = try await BerryFlavor.baseResources(from: 2, count: 3)
        #expect(secondBaseResources.count == 3)
        #expect(secondBaseResources.last?.id == "5")
        #expect(secondBaseResources.first?.id == "3")
        #expect(secondBaseResources.first?.name == "sweet")
        #expect(secondBaseResources.first?.type == "berry-flavor")
    }

    @Test func testSelectAllBerryFlavors() async throws {
        let berryFlavors = try await BerryFlavor.selectAll(count: 5)
        #expect(berryFlavors.count == 5)
        #expect(berryFlavors.first?.id == 1)
        #expect(berryFlavors.first?.name.lowercased() == "spicy")
        #expect(berryFlavors.last?.id == 5)
        #expect(berryFlavors.last?.name.lowercased() == "sour")
    }

    @Test func testFetchDryByID() async throws {
        let dry = try await BerryFlavor.selectOne(by: 2)
        #expect(dry.id == 2)
        #expect(dry.name.lowercased() == "dry")
        #expect(dry.berries.contains(where: { $0.berry.name.lowercased() == "grepa" }))
        #expect(dry.berries.contains(where: { $0.berry.name.lowercased() == "cornn" }))
    }

    @Test func testFetchDryByName() async throws {
        let dry = try await BerryFlavor.selectOne(by: "dry")
        #expect(dry.id == 2)
        #expect(dry.name.lowercased() == "dry")
        #expect(dry.berries.contains(where: { $0.berry.name.lowercased() == "grepa" }))
        #expect(dry.berries.contains(where: { $0.berry.name.lowercased() == "cornn" }))
    }

    @Test func testFetchBitterByID() async throws {
        let bitter = try await BerryFlavor.selectOne(by: 4)
        #expect(bitter.id == 4)
        #expect(bitter.name.lowercased() == "bitter")
        #expect(bitter.berries.contains(where: { $0.berry.name.lowercased() == "colbur" }))
        #expect(bitter.berries.contains(where: { $0.berry.name.lowercased() == "oran" }))
    }

    @Test func testFetchBitterByName() async throws {
        let bitter = try await BerryFlavor.selectOne(by: "bitter")
        #expect(bitter.id == 4)
        #expect(bitter.name.lowercased() == "bitter")
        #expect(bitter.berries.contains(where: { $0.berry.name.lowercased() == "colbur" }))
        #expect(bitter.berries.contains(where: { $0.berry.name.lowercased() == "oran" }))
    }

    @Test func testFetchInexistingBerryFlavor() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await BerryFlavor.selectOne(by: "unknown")
        })
    }
}
