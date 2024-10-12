import Foundation

// MARK: - Example Usage

let networkService = NetworkServiceImpl()
let releaseDatabaseService = ReleaseDatabaseServiceImpl()
let debugDatabaseService = DebugDatabaseServiceImpl()

let userRepositoryRelease = UserRepository(networkService: networkService, databaseService: releaseDatabaseService)
userRepositoryRelease.updateUserData()

let userRepositoryDebug = UserRepository(networkService: networkService, databaseService: debugDatabaseService)
userRepositoryDebug.updateUserData()
