//
//  BerryFirmnessTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 12/04/2025.
//

@testable import PokeAPIService
import Testing

struct BerryFirmnessTest {
    // MARK: - Base Resources

    @Test func testFecthBaseResources() async throws {
        let baseResources = try await BerryFirmness.baseResources(from: 0, count: 3)
        #expect(baseResources.count == 3)
        #expect(baseResources.first?.id == "1")
        #expect(baseResources.first?.name == "very-soft")
        #expect(baseResources.first?.type == "berry-firmness")
        #expect(baseResources.last?.id == "3")
        #expect(baseResources.last?.name == "hard")
        #expect(baseResources.last?.type == "berry-firmness")
    }

    @Test func testFecthPaginatedBaseResources() async throws {
        let baseResources = try await BerryFirmness.baseResources(from: 3, count: 2)
        #expect(baseResources.count == 2)
        #expect(baseResources.first?.id == "4")
        #expect(baseResources.first?.name == "very-hard")
        #expect(baseResources.first?.type == "berry-firmness")
        #expect(baseResources.last?.id == "5")
        #expect(baseResources.last?.name == "super-hard")
        #expect(baseResources.last?.type == "berry-firmness")
    }

    // MARK: - Select All

    @Test func testSelectDefaultGroupOfBerryFirmness() async throws {
        let group = try await BerryFirmness.selectAll()
        #expect(group.count == 5)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "very-soft")
        #expect(group.last?.id == 5)
        #expect(group.last?.name.lowercased() == "super-hard")
    }

    @Test func testSelectLimitedGroupOfBerryFirmness() async throws {
        let group = try await BerryFirmness.selectAll(count: 3)
        #expect(group.count == 3)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "very-soft")
        #expect(group.last?.id == 3)
        #expect(group.last?.name.lowercased() == "hard")
    }

    @Test func testSelectPaginatedGroupOfBerryFirmness() async throws {
        let group = try await BerryFirmness.selectAll(from: 3, count: 2)
        #expect(group.count == 2)
        #expect(group.first?.id == 4)
        #expect(group.first?.name.lowercased() == "very-hard")
        #expect(group.last?.id == 5)
        #expect(group.last?.name.lowercased() == "super-hard")
    }

    // MARK: - Select One By ID

    @Test func testSelectVerySoftByID() async throws {
        let firmness = try await BerryFirmness.selectOne(by: 1)
        #expect(firmness.id == 1)
        #expect(firmness.name.lowercased() == "very-soft")
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "pecha" }))
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "tanga" }))
    }

    @Test func testSelectHardByID() async throws {
        let firmness = try await BerryFirmness.selectOne(by: 3)
        #expect(firmness.id == 3)
        #expect(firmness.name.lowercased() == "hard")
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "wiki" }))
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "pinap" }))
    }

    @Test func testFetchSelectHardByID() async throws {
        let firmness = try await BerryFirmness.selectOne(by: 5)
        #expect(firmness.id == 5)
        #expect(firmness.name.lowercased() == "super-hard")
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "chesto" }))
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "nomel" }))
    }

    // MARK: - Select One By Name

    @Test func testSelectVerySoftByName() async throws {
        let firmness = try await BerryFirmness.selectOne(by: "very-soft")
        #expect(firmness.id == 1)
        #expect(firmness.name.lowercased() == "very-soft")
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "pecha" }))
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "tanga" }))
    }

    @Test func testSelectHardByName() async throws {
        let firmness = try await BerryFirmness.selectOne(by: "hard")
        #expect(firmness.id == 3)
        #expect(firmness.name.lowercased() == "hard")
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "wiki" }))
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "pinap" }))
    }

    @Test func testFetchSelectHardByName() async throws {
        let firmness = try await BerryFirmness.selectOne(by: "super-hard")
        #expect(firmness.id == 5)
        #expect(firmness.name.lowercased() == "super-hard")
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "chesto" }))
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "nomel" }))
    }

    // MARK: - Random

    @Test func testOptionalOnRandomBerryFirmness() async throws {
        let randomID = Int.random(in: 1 ... 5)
        PokeLogger.info("Select BerryFirmness ID: \(randomID)")
        _ = try await BerryFirmness.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func testFetchInexistingBerryFirmness() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await BerryFirmness.selectOne(by: "unknown")
        })
    }
}
