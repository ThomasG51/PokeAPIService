//
//  GamesTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/03/2025.
//

@testable import PokeAPIService
import Testing

struct GameVersionTest {
    @Test func testGameVersionBaseResourceWithPagination() async throws {
        let firstBaseResources = try await GameVersion.baseResources(from: 0, count: 3)
        #expect(firstBaseResources.count == 3)
        #expect(firstBaseResources.first?.id == "1")
        #expect(firstBaseResources.first?.name == "red")
        #expect(firstBaseResources.first?.type == "version")
        #expect(firstBaseResources.last?.id == "3")
        #expect(firstBaseResources.last?.name == "yellow")
        #expect(firstBaseResources.last?.type == "version")
    }

    @Test func testGameVersionSelectAll() async throws {
        let gameVersions = try await GameVersion.selectAll()
        #expect(gameVersions.count == 20)
    }

    @Test func testGameVersionSelectYellowByID() async throws {
        let gameVersionYellow = try await GameVersion.selectOne(by: 3)
        #expect(gameVersionYellow.id == 3)
        #expect(gameVersionYellow.name == "yellow")
        #expect(gameVersionYellow.names.filter { $0.language.name == "fr" }.first?.name == "Jaune")
    }

    @Test func testGameVersionSelectYellowByName() async throws {
        let gameVersionYellow = try await GameVersion.selectOne(by: 3)
        #expect(gameVersionYellow.id == 3)
        #expect(gameVersionYellow.name == "yellow")
        #expect(gameVersionYellow.names.filter { $0.language.name == "fr" }.first?.name == "Jaune")
    }

    @Test func testGameVersionSelectGoldByID() async throws {
        let gameVersionGold = try await GameVersion.selectOne(by: 4)
        #expect(gameVersionGold.id == 4)
        #expect(gameVersionGold.name == "gold")
        #expect(gameVersionGold.names.filter { $0.language.name == "fr" }.first?.name == "Or")
    }

    @Test func testGameVersionSelectGoldByName() async throws {
        let gameVersionGold = try await GameVersion.selectOne(by: 4)
        #expect(gameVersionGold.id == 4)
        #expect(gameVersionGold.name == "gold")
        #expect(gameVersionGold.names.filter { $0.language.name == "fr" }.first?.name == "Or")
    }

    @Test func testFetchInexistingGameVersion() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await GameVersion.selectOne(by: "unknown")
        })
    }
}
