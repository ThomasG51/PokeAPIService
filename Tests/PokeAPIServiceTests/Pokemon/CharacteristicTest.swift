//
//  CharacteristicTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 26/04/2025.
//

@testable import PokeAPIService
import Testing

struct CharacteristicTest {
    // MARK: - Base Resources

    @Test func testFecthBaseResources() async throws {
        let lightResources = try await Characteristic.lightResources(from: 0, count: 15)
        #expect(lightResources.count == 15)
        #expect(lightResources.last?.id == "15")
        #expect(lightResources.first?.id == "1")
        #expect(lightResources.first?.name == "no name for this resource")
        #expect(lightResources.first?.type == "characteristic")
    }

    @Test func testFecthPaginatedBaseResources() async throws {
        let lightResources = try await Characteristic.lightResources(from: 15, count: 15)
        #expect(lightResources.count == 15)
        #expect(lightResources.last?.id == "30")
        #expect(lightResources.first?.id == "16")
        #expect(lightResources.first?.name == "no name for this resource")
        #expect(lightResources.first?.type == "characteristic")
    }

    // MARK: - Select All

    @Test func testSelectDefaultGroupOfCharacteristic() async throws {
        let group = try await Characteristic.selectAll()
        #expect(group.count == 20)
        #expect(group.first?.id == 1)
        #expect(group.first?.descriptions.contains(where: { $0.description == "Loves to eat" }) == true)
        #expect(group.first?.highestStat.name == "hp")
        #expect(group.last?.id == 20)
        #expect(group.last?.descriptions.contains(where: { $0.description == "Likes to fight" }) == true)
        #expect(group.last?.highestStat.name == "attack")
    }

    @Test func testSelectLimitedGroupOfCharacteristic() async throws {
        let group = try await Characteristic.selectAll(count: 10)
        #expect(group.count == 10)
        #expect(group.first?.id == 1)
        #expect(group.first?.descriptions.contains(where: { $0.description == "Loves to eat" }) == true)
        #expect(group.first?.highestStat.name == "hp")
        #expect(group.last?.id == 10)
        #expect(group.last?.descriptions.contains(where: { $0.description == "Mischievous" }) == true)
        #expect(group.last?.highestStat.name == "special-attack")
    }

    @Test func testSelectPaginatedGroupOfCharacteristic() async throws {
        let group = try await Characteristic.selectAll(from: 15, count: 15)
        #expect(group.count == 15)
        #expect(group.first?.id == 16)
        #expect(group.first?.descriptions.contains(where: { $0.description == "Thoroughly cunning" }) == true)
        #expect(group.first?.highestStat.name == "special-attack")
        #expect(group.last?.id == 30)
        #expect(group.last?.descriptions.contains(where: { $0.description == "Quick to flee" }) == true)
        #expect(group.last?.highestStat.name == "speed")
    }

    // MARK: - Select One By ID

    @Test func testSelectCharacteristicOneByID() async throws {
        let characteristic = try await Characteristic.selectOne(by: 1)
        #expect(characteristic.id == 1)
        #expect(characteristic.highestStat.name == "hp")
        #expect(characteristic.descriptions.contains(where: { $0.description == "Loves to eat" }))
        #expect(characteristic.geneModulo == 0)
        #expect(characteristic.possibleValues == [0, 5, 10, 15, 20, 25, 30])
    }

    @Test func testSelectCharacteristicTenByID() async throws {
        let characteristic = try await Characteristic.selectOne(by: 10)
        #expect(characteristic.id == 10)
        #expect(characteristic.highestStat.name == "special-attack")
        #expect(characteristic.descriptions.contains(where: { $0.description == "Mischievous" }))
        #expect(characteristic.geneModulo == 1)
        #expect(characteristic.possibleValues == [1, 6, 11, 16, 21, 26, 31])
    }

    @Test func testSelectCharacteristicTwentyByID() async throws {
        let characteristic = try await Characteristic.selectOne(by: 20)
        #expect(characteristic.id == 20)
        #expect(characteristic.highestStat.name == "attack")
        #expect(characteristic.descriptions.contains(where: { $0.description == "Likes to fight" }))
        #expect(characteristic.geneModulo == 3)
        #expect(characteristic.possibleValues == [3, 8, 13, 18, 23, 28])
    }

    @Test func testSelectCharacteristicThirtyByID() async throws {
        let characteristic = try await Characteristic.selectOne(by: 30)
        #expect(characteristic.id == 30)
        #expect(characteristic.highestStat.name == "speed")
        #expect(characteristic.descriptions.contains(where: { $0.description == "Quick to flee" }))
        #expect(characteristic.geneModulo == 4)
        #expect(characteristic.possibleValues == [4, 9, 14, 19, 24, 29])
    }

    // MARK: - Random

    @Test func testOptionalOnRandomCharacteristic() async throws {
        let randomID = Int.random(in: 1 ... 30)
        PokeLogger.info("Characteristic ID: \(randomID)")
        _ = try await Characteristic.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func testFetchInexistingCharacteristic() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await Characteristic.selectOne(by: "unknown")
        })
    }
}
