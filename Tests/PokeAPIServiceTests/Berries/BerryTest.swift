//
//  BerryTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 12/04/2025.
//

@testable import PokeAPIService
import Testing

struct BerryTest {
    // MARK: - Base Resources

    @Test func testFecthBaseResources() async throws {
        let lightResources = try await Berry.lightResources(from: 0, count: 30)
        #expect(lightResources.count == 30)
        #expect(lightResources.first?.id == "1")
        #expect(lightResources.first?.name == "cheri")
        #expect(lightResources.first?.type == "berry")
        #expect(lightResources.last?.id == "30")
        #expect(lightResources.last?.name == "nomel")
        #expect(lightResources.last?.type == "berry")
    }

    @Test func testFecthPaginatedBaseResources() async throws {
        let lightResources = try await Berry.lightResources(from: 30, count: 30)
        #expect(lightResources.count == 30)
        #expect(lightResources.first?.id == "31")
        #expect(lightResources.first?.name == "spelon")
        #expect(lightResources.first?.type == "berry")
        #expect(lightResources.last?.id == "60")
        #expect(lightResources.last?.name == "enigma")
        #expect(lightResources.last?.type == "berry")
    }

    // MARK: - Select All

    @Test func testSelectDefaultGroupOfBerry() async throws {
        let group = try await Berry.selectAll()
        #expect(group.count == 20)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "cheri")
        #expect(group.last?.id == 20)
        #expect(group.last?.name.lowercased() == "pinap")
    }

    @Test func testSelectLimitedGroupOfBerry() async throws {
        let group = try await Berry.selectAll(count: 30)
        #expect(group.count == 30)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "cheri")
        #expect(group.last?.id == 30)
        #expect(group.last?.name.lowercased() == "nomel")
    }

    @Test func testSelectPaginatedGroupOfBerry() async throws {
        let group = try await Berry.selectAll(from: 30, count: 30)
        #expect(group.count == 30)
        #expect(group.first?.id == 31)
        #expect(group.first?.name.lowercased() == "spelon")
        #expect(group.last?.id == 60)
        #expect(group.last?.name.lowercased() == "enigma")
    }

    // MARK: - Select One By ID

    @Test func testSelectCheriByID() async throws {
        let berry = try await Berry.selectOne(by: 1)
        #expect(berry.id == 1)
        #expect(berry.name.lowercased() == "cheri")
        #expect(berry.growthTime == 3)
        #expect(berry.firmness.name.lowercased() == "soft")
        #expect(berry.flavors.contains(where: { $0.flavor.name.lowercased() == "spicy" }))
        #expect(berry.flavors.contains(where: { $0.flavor.name.lowercased() == "sweet" }))
        #expect(berry.item.name.lowercased() == "cheri-berry")
        #expect(berry.naturalGiftType.name.lowercased() == "fire")
    }

    @Test func testSelectNomelByID() async throws {
        let berry = try await Berry.selectOne(by: 30)
        #expect(berry.id == 30)
        #expect(berry.name.lowercased() == "nomel")
        #expect(berry.growthTime == 6)
        #expect(berry.firmness.name.lowercased() == "super-hard")
        #expect(berry.flavors.contains(where: { $0.flavor.name.lowercased() == "spicy" }))
        #expect(berry.flavors.contains(where: { $0.flavor.name.lowercased() == "sweet" }))
        #expect(berry.item.name.lowercased() == "nomel-berry")
        #expect(berry.naturalGiftType.name.lowercased() == "dragon")
    }

    @Test func testSelectEnigmaByID() async throws {
        let berry = try await Berry.selectOne(by: 60)
        #expect(berry.id == 60)
        #expect(berry.name.lowercased() == "enigma")
        #expect(berry.growthTime == 24)
        #expect(berry.firmness.name.lowercased() == "hard")
        #expect(berry.flavors.contains(where: { $0.flavor.name.lowercased() == "dry" }))
        #expect(berry.flavors.contains(where: { $0.flavor.name.lowercased() == "sour" }))
        #expect(berry.item.name.lowercased() == "enigma-berry")
        #expect(berry.naturalGiftType.name.lowercased() == "bug")
    }

    // MARK: - Select One By Name

    @Test func testSelectCheriByName() async throws {
        let berry = try await Berry.selectOne(by: "cheri")
        #expect(berry.id == 1)
        #expect(berry.name.lowercased() == "cheri")
        #expect(berry.growthTime == 3)
        #expect(berry.firmness.name.lowercased() == "soft")
        #expect(berry.flavors.contains(where: { $0.flavor.name.lowercased() == "spicy" }))
        #expect(berry.flavors.contains(where: { $0.flavor.name.lowercased() == "sweet" }))
        #expect(berry.item.name.lowercased() == "cheri-berry")
        #expect(berry.naturalGiftType.name.lowercased() == "fire")
    }

    @Test func testSelectNomelByName() async throws {
        let berry = try await Berry.selectOne(by: "nomel")
        #expect(berry.id == 30)
        #expect(berry.name.lowercased() == "nomel")
        #expect(berry.growthTime == 6)
        #expect(berry.firmness.name.lowercased() == "super-hard")
        #expect(berry.flavors.contains(where: { $0.flavor.name.lowercased() == "spicy" }))
        #expect(berry.flavors.contains(where: { $0.flavor.name.lowercased() == "sweet" }))
        #expect(berry.item.name.lowercased() == "nomel-berry")
        #expect(berry.naturalGiftType.name.lowercased() == "dragon")
    }

    @Test func testSelectEnigmaByName() async throws {
        let berry = try await Berry.selectOne(by: "enigma")
        #expect(berry.id == 60)
        #expect(berry.name.lowercased() == "enigma")
        #expect(berry.growthTime == 24)
        #expect(berry.firmness.name.lowercased() == "hard")
        #expect(berry.flavors.contains(where: { $0.flavor.name.lowercased() == "dry" }))
        #expect(berry.flavors.contains(where: { $0.flavor.name.lowercased() == "sour" }))
        #expect(berry.item.name.lowercased() == "enigma-berry")
        #expect(berry.naturalGiftType.name.lowercased() == "bug")
    }

    // MARK: - Random

    @Test func testOptionalOnRandomBerry() async throws {
        let randomID = Int.random(in: 1 ... 64)
        PokeLogger.info("Select Berry ID: \(randomID)")
        _ = try await Berry.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func testSelectInexistingBerry() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await Berry.selectOne(by: "unknown")
        })
    }
}
