//
//  GameVersionTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/03/2025.
//

@testable import PokeAPIService
import Testing

struct GameVersionTest {
    // MARK: - Base Resources

    @Test func testFecthBaseResources() async throws {
        let baseResources = try await GameVersion.baseResources(from: 0, count: 20)
        #expect(baseResources.count == 20)
        #expect(baseResources.last?.id == "20")
        #expect(baseResources.first?.id == "1")
        #expect(baseResources.first?.name == "red")
        #expect(baseResources.first?.type == "version")
    }

    @Test func testFecthPaginatedBaseResources() async throws {
        let baseResources = try await GameVersion.baseResources(from: 20, count: 20)
        #expect(baseResources.count == 20)
        #expect(baseResources.last?.id == "40")
        #expect(baseResources.first?.id == "21")
        #expect(baseResources.first?.name == "black-2")
        #expect(baseResources.first?.type == "version")
    }

    // MARK: - Select All

    @Test func testSelectDefaultGroupOfGameVersion() async throws {
        let group = try await GameVersion.selectAll()
        #expect(group.count == 20)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "red")
        #expect(group.last?.id == 20)
        #expect(group.last?.name.lowercased() == "xd")
    }

    @Test func testSelectLimitedGroupOfGameVersion() async throws {
        let group = try await GameVersion.selectAll(count: 43)
        #expect(group.count == 43)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "red")
        #expect(group.last?.id == 43)
        #expect(group.last?.name.lowercased() == "the-indigo-disk")
    }

    @Test func testSelectPaginatedGroupOfGameVersion() async throws {
        let group = try await GameVersion.selectAll(from: 20, count: 10)
        #expect(group.count == 10)
        #expect(group.first?.id == 21)
        #expect(group.first?.name.lowercased() == "black-2")
        #expect(group.last?.id == 30)
        #expect(group.last?.name.lowercased() == "ultra-moon")
    }

    // MARK: - Select One By ID

    @Test func testSelectRedByID() async throws {
        let gameVersion = try await GameVersion.selectOne(by: 1)
        #expect(gameVersion.id == 1)
        #expect(gameVersion.name == "red")
        #expect(gameVersion.versionGroup.name == "red-blue")
    }

    @Test func testSelectGoldByID() async throws {
        let gameVersion = try await GameVersion.selectOne(by: 4)
        #expect(gameVersion.id == 4)
        #expect(gameVersion.name == "gold")
        #expect(gameVersion.versionGroup.name == "gold-silver")
    }

    @Test func testSelectEmeraldByID() async throws {
        let gameVersion = try await GameVersion.selectOne(by: 9)
        #expect(gameVersion.id == 9)
        #expect(gameVersion.name == "emerald")
        #expect(gameVersion.versionGroup.name == "emerald")
    }

    @Test func testSelectWhiteByID() async throws {
        let gameVersion = try await GameVersion.selectOne(by: 18)
        #expect(gameVersion.id == 18)
        #expect(gameVersion.name == "white")
        #expect(gameVersion.versionGroup.name == "black-white")
    }

    @Test func testSelectSunByID() async throws {
        let gameVersion = try await GameVersion.selectOne(by: 27)
        #expect(gameVersion.id == 27)
        #expect(gameVersion.name == "sun")
        #expect(gameVersion.versionGroup.name == "sun-moon")
    }

    @Test func testSelectScarletID() async throws {
        let gameVersion = try await GameVersion.selectOne(by: 40)
        #expect(gameVersion.id == 40)
        #expect(gameVersion.name == "scarlet")
        #expect(gameVersion.versionGroup.name == "scarlet-violet")
    }

    // MARK: - Select One By Name

    @Test func testSelectRedByName() async throws {
        let gameVersion = try await GameVersion.selectOne(by: "red")
        #expect(gameVersion.id == 1)
        #expect(gameVersion.name == "red")
        #expect(gameVersion.versionGroup.name == "red-blue")
    }

    @Test func testSelectGoldByName() async throws {
        let gameVersion = try await GameVersion.selectOne(by: "gold")
        #expect(gameVersion.id == 4)
        #expect(gameVersion.name == "gold")
        #expect(gameVersion.versionGroup.name == "gold-silver")
    }

    @Test func testSelectEmeraldByName() async throws {
        let gameVersion = try await GameVersion.selectOne(by: "emerald")
        #expect(gameVersion.id == 9)
        #expect(gameVersion.name == "emerald")
        #expect(gameVersion.versionGroup.name == "emerald")
    }

    @Test func testSelectWhiteByName() async throws {
        let gameVersion = try await GameVersion.selectOne(by: "white")
        #expect(gameVersion.id == 18)
        #expect(gameVersion.name == "white")
        #expect(gameVersion.versionGroup.name == "black-white")
    }

    @Test func testSelectSunByName() async throws {
        let gameVersion = try await GameVersion.selectOne(by: "sun")
        #expect(gameVersion.id == 27)
        #expect(gameVersion.name == "sun")
        #expect(gameVersion.versionGroup.name == "sun-moon")
    }

    @Test func testSelectScarletName() async throws {
        let gameVersion = try await GameVersion.selectOne(by: "scarlet")
        #expect(gameVersion.id == 40)
        #expect(gameVersion.name == "scarlet")
        #expect(gameVersion.versionGroup.name == "scarlet-violet")
    }

    // MARK: - Random
    
    @Test func testOptionalOnRandomGameVersion() async throws {
        let randomID = Int.random(in: 1 ... 43)
        PokeLogger.info("GameVersion ID: \(randomID)")
        _ = try await GameVersion.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func testFetchInexistingGameVersion() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await GameVersion.selectOne(by: "unknown")
        })
    }
}
