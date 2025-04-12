//
//  BerryFirmnessTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 12/04/2025.
//

@testable import PokeAPIService
import Testing

struct BerryFirmnessTest {
    @Test func testBaseResourcesWithPagination() async throws {
        let firstBaseResources = try await BerryFirmness.baseResources(from: 0, count: 2)
        #expect(firstBaseResources.count == 2)
        #expect(firstBaseResources.last?.id == "2")
        #expect(firstBaseResources.first?.id == "1")
        #expect(firstBaseResources.first?.name == "very-soft")
        #expect(firstBaseResources.first?.type == "berry-firmness")

        let secondBaseResources = try await BerryFirmness.baseResources(from: 2, count: 3)
        #expect(secondBaseResources.count == 3)
        #expect(secondBaseResources.last?.id == "5")
        #expect(secondBaseResources.first?.id == "3")
        #expect(secondBaseResources.first?.name == "hard")
        #expect(secondBaseResources.first?.type == "berry-firmness")
    }

    @Test func testSelectAllBerryFirmnesses() async throws {
        let berryFirmnesses = try await BerryFirmness.selectAll(count: 5)
        #expect(berryFirmnesses.count == 5)
        #expect(berryFirmnesses.first?.id == 1)
        #expect(berryFirmnesses.first?.name.lowercased() == "very-soft")
        #expect(berryFirmnesses.last?.id == 5)
        #expect(berryFirmnesses.last?.name.lowercased() == "super-hard")
    }

    @Test func testFetchSoftByID() async throws {
        let soft = try await BerryFirmness.selectOne(by: 2)
        #expect(soft.id == 2)
        #expect(soft.name.lowercased() == "soft")
        #expect(soft.berries.contains(where: { $0.name.lowercased() == "cheri" }))
        #expect(soft.berries.contains(where: { $0.name.lowercased() == "tamato" }))
    }

    @Test func testFetchSoftByName() async throws {
        let soft = try await BerryFirmness.selectOne(by: "soft")
        #expect(soft.id == 2)
        #expect(soft.name.lowercased() == "soft")
        #expect(soft.berries.contains(where: { $0.name.lowercased() == "cheri" }))
        #expect(soft.berries.contains(where: { $0.name.lowercased() == "tamato" }))
    }

    @Test func testFetchHardByID() async throws {
        let soft = try await BerryFirmness.selectOne(by: 4)
        #expect(soft.id == 4)
        #expect(soft.name.lowercased() == "very-hard")
        #expect(soft.berries.contains(where: { $0.name.lowercased() == "leppa" }))
        #expect(soft.berries.contains(where: { $0.name.lowercased() == "coba" }))
    }

    @Test func testFetchHardByName() async throws {
        let soft = try await BerryFirmness.selectOne(by: "very-hard")
        #expect(soft.id == 4)
        #expect(soft.name.lowercased() == "very-hard")
        #expect(soft.berries.contains(where: { $0.name.lowercased() == "leppa" }))
        #expect(soft.berries.contains(where: { $0.name.lowercased() == "coba" }))
    }

    @Test func testFetchInexistingBerryFirmness() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await BerryFirmness.selectOne(by: "unknown")
        })
    }
}
