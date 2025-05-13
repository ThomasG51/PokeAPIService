//
//  VersionTest.swift
//  PokeAPIService
//
//  Created by Thomas George on 21/03/2025.
//

@testable import PokeAPIService
import Testing

struct VersionTest {
    // MARK: - Base Resources

    @Test func fecthBaseResources() async throws {
        let lightResources = try await Version.lightResources(from: 0, count: 20)
        #expect(lightResources.count == 20)
        #expect(lightResources.last?.id == "20")
        #expect(lightResources.first?.id == "1")
        #expect(lightResources.first?.name == "red")
        #expect(lightResources.first?.type == "version")
    }

    @Test func fecthPaginatedBaseResources() async throws {
        let lightResources = try await Version.lightResources(from: 20, count: 20)
        #expect(lightResources.count == 20)
        #expect(lightResources.last?.id == "40")
        #expect(lightResources.first?.id == "21")
        #expect(lightResources.first?.name == "black-2")
        #expect(lightResources.first?.type == "version")
    }

    // MARK: - Select All

    @Test func selectDefaultGroupOfVersion() async throws {
        let group = try await Version.selectAll()
        #expect(group.count == 20)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "red")
        #expect(group.last?.id == 20)
        #expect(group.last?.name.lowercased() == "xd")
    }

    @Test func selectLimitedGroupOfVersion() async throws {
        let group = try await Version.selectAll(count: 43)
        #expect(group.count == 43)
        #expect(group.first?.id == 1)
        #expect(group.first?.name.lowercased() == "red")
        #expect(group.last?.id == 43)
        #expect(group.last?.name.lowercased() == "the-indigo-disk")
    }

    @Test func selectPaginatedGroupOfVersion() async throws {
        let group = try await Version.selectAll(from: 20, count: 10)
        #expect(group.count == 10)
        #expect(group.first?.id == 21)
        #expect(group.first?.name.lowercased() == "black-2")
        #expect(group.last?.id == 30)
        #expect(group.last?.name.lowercased() == "ultra-moon")
    }

    // MARK: - Select One By ID

    @Test func selectRedByID() async throws {
        let version = try await Version.selectOne(by: 1)
        #expect(version.id == 1)
        #expect(version.name == "red")
        #expect(version.versionGroup.name == "red-blue")
    }

    @Test func selectGoldByID() async throws {
        let version = try await Version.selectOne(by: 4)
        #expect(version.id == 4)
        #expect(version.name == "gold")
        #expect(version.versionGroup.name == "gold-silver")
    }

    @Test func selectEmeraldByID() async throws {
        let version = try await Version.selectOne(by: 9)
        #expect(version.id == 9)
        #expect(version.name == "emerald")
        #expect(version.versionGroup.name == "emerald")
    }

    @Test func selectWhiteByID() async throws {
        let version = try await Version.selectOne(by: 18)
        #expect(version.id == 18)
        #expect(version.name == "white")
        #expect(version.versionGroup.name == "black-white")
    }

    @Test func selectSunByID() async throws {
        let version = try await Version.selectOne(by: 27)
        #expect(version.id == 27)
        #expect(version.name == "sun")
        #expect(version.versionGroup.name == "sun-moon")
    }

    @Test func selectScarletID() async throws {
        let version = try await Version.selectOne(by: 40)
        #expect(version.id == 40)
        #expect(version.name == "scarlet")
        #expect(version.versionGroup.name == "scarlet-violet")
    }

    // MARK: - Select One By Name

    @Test func selectRedByName() async throws {
        let version = try await Version.selectOne(by: "red")
        #expect(version.id == 1)
        #expect(version.name == "red")
        #expect(version.versionGroup.name == "red-blue")
    }

    @Test func selectGoldByName() async throws {
        let version = try await Version.selectOne(by: "gold")
        #expect(version.id == 4)
        #expect(version.name == "gold")
        #expect(version.versionGroup.name == "gold-silver")
    }

    @Test func selectEmeraldByName() async throws {
        let version = try await Version.selectOne(by: "emerald")
        #expect(version.id == 9)
        #expect(version.name == "emerald")
        #expect(version.versionGroup.name == "emerald")
    }

    @Test func selectWhiteByName() async throws {
        let version = try await Version.selectOne(by: "white")
        #expect(version.id == 18)
        #expect(version.name == "white")
        #expect(version.versionGroup.name == "black-white")
    }

    @Test func selectSunByName() async throws {
        let version = try await Version.selectOne(by: "sun")
        #expect(version.id == 27)
        #expect(version.name == "sun")
        #expect(version.versionGroup.name == "sun-moon")
    }

    @Test func selectScarletName() async throws {
        let version = try await Version.selectOne(by: "scarlet")
        #expect(version.id == 40)
        #expect(version.name == "scarlet")
        #expect(version.versionGroup.name == "scarlet-violet")
    }

    // MARK: - Random

    @Test func optionalOnRandomVersion() async throws {
        let randomID = Int.random(in: 1 ... 43)
        PokeLogger.info("Select Version ID: \(randomID)")
        _ = try await Version.selectOne(by: randomID)
    }

    // MARK: - Error

    @Test func selectInexistingVersion() async throws {
        await #expect(throws: PokeAPIServiceError.notFound, performing: {
            try await Version.selectOne(by: "unknown")
        })
    }
}
