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

    @Test func fecthBaseResources() async throws {
        let lightResources = try await BerryFirmness.lightResources(from: 0, count: 3)
        #expect(lightResources.count == 3)
        #expect(lightResources.first?.id == "1")
        #expect(lightResources.first?.name == "very-soft")
        #expect(lightResources.first?.type == "berry-firmness")
        #expect(lightResources.last?.id == "3")
        #expect(lightResources.last?.name == "hard")
        #expect(lightResources.last?.type == "berry-firmness")
    }

    @Test func fecthPaginatedBaseResources() async throws {
        let lightResources = try await BerryFirmness.lightResources(from: 3, count: 2)
        #expect(lightResources.count == 2)
        #expect(lightResources.first?.id == "4")
        #expect(lightResources.first?.name == "very-hard")
        #expect(lightResources.first?.type == "berry-firmness")
        #expect(lightResources.last?.id == "5")
        #expect(lightResources.last?.name == "super-hard")
        #expect(lightResources.last?.type == "berry-firmness")
    }

    // MARK: - Select All

    @Test func selectDefaultGroupOfBerryFirmness() async throws {
        let group = try await BerryFirmness.selectAll()
        #expect(group.count == 5)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "very-soft")
        #expect(group.last?.id == 5)
        #expect(group.last?.name.lowercased() == "super-hard")
    }

    @Test func selectLimitedGroupOfBerryFirmness() async throws {
        let group = try await BerryFirmness.selectAll(count: 3)
        #expect(group.count == 3)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "very-soft")
        #expect(group.last?.id == 3)
        #expect(group.last?.name.lowercased() == "hard")
    }

    @Test func selectPaginatedGroupOfBerryFirmness() async throws {
        let group = try await BerryFirmness.selectAll(from: 3, count: 2)
        #expect(group.count == 2)
        #expect(group.first?.id == 4)
        #expect(group.first?.name.lowercased() == "very-hard")
        #expect(group.last?.id == 5)
        #expect(group.last?.name.lowercased() == "super-hard")
    }

    // MARK: - Select One By ID

    @Test func selectVerySoftByID() async throws {
        let firmness = try await BerryFirmness.selectOne(by: 1)
        #expect(firmness.id == 1)
        #expect(firmness.name.lowercased() == "very-soft")
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "pecha" }))
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "tanga" }))
    }

    @Test func selectHardByID() async throws {
        let firmness = try await BerryFirmness.selectOne(by: 3)
        #expect(firmness.id == 3)
        #expect(firmness.name.lowercased() == "hard")
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "wiki" }))
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "pinap" }))
    }

    @Test func fetchSelectHardByID() async throws {
        let firmness = try await BerryFirmness.selectOne(by: 5)
        #expect(firmness.id == 5)
        #expect(firmness.name.lowercased() == "super-hard")
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "chesto" }))
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "nomel" }))
    }

    // MARK: - Select One By Name

    @Test func selectVerySoftByName() async throws {
        let firmness = try await BerryFirmness.selectOne(by: "very-soft")
        #expect(firmness.id == 1)
        #expect(firmness.name.lowercased() == "very-soft")
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "pecha" }))
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "tanga" }))
    }

    @Test func selectHardByName() async throws {
        let firmness = try await BerryFirmness.selectOne(by: "hard")
        #expect(firmness.id == 3)
        #expect(firmness.name.lowercased() == "hard")
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "wiki" }))
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "pinap" }))
    }

    @Test func fetchSelectHardByName() async throws {
        let firmness = try await BerryFirmness.selectOne(by: "super-hard")
        #expect(firmness.id == 5)
        #expect(firmness.name.lowercased() == "super-hard")
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "chesto" }))
        #expect(firmness.berries.contains(where: { $0.name.lowercased() == "nomel" }))
    }

    // MARK: - Random

    @Test func optionalOnRandomBerryFirmness() async throws {
        let randomID = Int.random(in: 1 ... 5)
        PokeLogger.info("Select BerryFirmness ID: \(randomID)")
        _ = try await BerryFirmness.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func fetchInexistingBerryFirmness() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await BerryFirmness.selectOne(by: "unknown")
        })
    }
}
