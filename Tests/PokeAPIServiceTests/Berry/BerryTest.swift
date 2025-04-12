//
//  BerryTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 12/04/2025.
//

@testable import PokeAPIService
import Testing

struct BerryTest {
    @Test func testBaseResourcesWithPagination() async throws {
        let firstBaseResources = try await Berry.baseResources(from: 0, count: 30)
        #expect(firstBaseResources.count == 30)
        #expect(firstBaseResources.last?.id == "30")
        #expect(firstBaseResources.first?.id == "1")
        #expect(firstBaseResources.first?.name == "cheri")
        #expect(firstBaseResources.first?.type == "berry")

        let secondBaseResources = try await Berry.baseResources(from: 30, count: 30)
        #expect(secondBaseResources.count == 30)
        #expect(secondBaseResources.last?.id == "60")
        #expect(secondBaseResources.first?.id == "31")
        #expect(secondBaseResources.first?.name == "spelon")
        #expect(secondBaseResources.first?.type == "berry")
    }

    @Test func testSelectAllBerries() async throws {
        let berries = try await Berry.selectAll(count: 64)
        #expect(berries.count == 64)
        #expect(berries.first?.id == 1)
        #expect(berries.first?.name.lowercased() == "cheri")
        #expect(berries.last?.id == 64)
        #expect(berries.last?.name.lowercased() == "rowap")
    }

    @Test func testFetchCheriByID() async throws {
        let cheri = try await Berry.selectOne(by: 1)
        #expect(cheri.id == 1)
        #expect(cheri.name.lowercased() == "cheri")
        #expect(cheri.growthTime == 3)
        #expect(cheri.firmness.name.lowercased() == "soft")
        #expect(cheri.flavors.contains(where: { $0.flavor.name.lowercased() == "spicy" }))
        #expect(cheri.flavors.contains(where: { $0.flavor.name.lowercased() == "sweet" }))
        #expect(cheri.item.name.lowercased() == "cheri-berry")
        #expect(cheri.naturalGiftType.name.lowercased() == "fire")
    }

    @Test func testFetchCheriByName() async throws {
        let cheri = try await Berry.selectOne(by: "cheri")
        #expect(cheri.id == 1)
        #expect(cheri.name.lowercased() == "cheri")
        #expect(cheri.growthTime == 3)
        #expect(cheri.firmness.name.lowercased() == "soft")
        #expect(cheri.flavors.contains(where: { $0.flavor.name.lowercased() == "spicy" }))
        #expect(cheri.flavors.contains(where: { $0.flavor.name.lowercased() == "sweet" }))
        #expect(cheri.item.name.lowercased() == "cheri-berry")
        #expect(cheri.naturalGiftType.name.lowercased() == "fire")
    }

    @Test func testFetchSpelonByID() async throws {
        let spelon = try await Berry.selectOne(by: 31)
        #expect(spelon.id == 31)
        #expect(spelon.name.lowercased() == "spelon")
        #expect(spelon.growthTime == 15)
        #expect(spelon.firmness.name.lowercased() == "soft")
        #expect(spelon.flavors.contains(where: { $0.flavor.name.lowercased() == "spicy" }))
        #expect(spelon.flavors.contains(where: { $0.flavor.name.lowercased() == "sweet" }))
        #expect(spelon.item.name.lowercased() == "spelon-berry")
        #expect(spelon.naturalGiftType.name.lowercased() == "dark")
    }

    @Test func testFetchSpelonByName() async throws {
        let spelon = try await Berry.selectOne(by: "spelon")
        #expect(spelon.id == 31)
        #expect(spelon.name.lowercased() == "spelon")
        #expect(spelon.growthTime == 15)
        #expect(spelon.firmness.name.lowercased() == "soft")
        #expect(spelon.flavors.contains(where: { $0.flavor.name.lowercased() == "spicy" }))
        #expect(spelon.flavors.contains(where: { $0.flavor.name.lowercased() == "sweet" }))
        #expect(spelon.item.name.lowercased() == "spelon-berry")
        #expect(spelon.naturalGiftType.name.lowercased() == "dark")
    }

    @Test func testFetchInexistingBerry() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await Berry.selectOne(by: "unknown")
        })
    }
}
