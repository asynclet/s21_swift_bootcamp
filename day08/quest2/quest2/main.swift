import Foundation
import Swinject

enum DIName: String {
    case release
    case debug
}

func factoryMethodDI() {
    let container = Container()

    container.register(NetworkService.self) { _ in NetworkServiceImpl() }
    container.register(DatabaseService.self) { _ in ReleaseDatabaseServiceImpl() }

    container.register(UserRepository.self) { resolver in
        guard let networkService = resolver.resolve(NetworkService.self),
              let databaseService = resolver.resolve(DatabaseService.self)
        else {
            fatalError("Problem with register UserRepository using existing NetworkService and DatabaseService")
        }
        return UserRepository(networkService: networkService, databaseService: databaseService)
    }

    guard let userRepository1 = container.resolve(UserRepository.self) else { return }
    userRepository1.updateUserData()

    guard let userRepository2 = container.resolve(UserRepository.self) else { return }

    let areSame = userRepository1 === userRepository2
    print("Are the two UserRepository objects the same (Factory Method)? \(areSame.toEmoji)")
}

func namedDependenciesDI() {
    let container = Container()

    container.register(NetworkService.self) { _ in NetworkServiceImpl() }
    container.register(DatabaseService.self, name: DIName.release.rawValue) { _ in ReleaseDatabaseServiceImpl() }
    container.register(DatabaseService.self, name: DIName.debug.rawValue) { _ in DebugDatabaseServiceImpl() }

    container.register(UserRepository.self, name: DIName.release.rawValue) { resolver in
        guard let networkService = resolver.resolve(NetworkService.self),
              let databaseService = resolver.resolve(DatabaseService.self, name: DIName.release.rawValue)
        else {
            fatalError("Problem with register UserRepository with named dependencies")
        }
        return UserRepository(networkService: networkService, databaseService: databaseService)
    }

    container.register(UserRepository.self, name: DIName.debug.rawValue) { resolver in
        guard let networkService = resolver.resolve(NetworkService.self),
              let databaseService = resolver.resolve(DatabaseService.self, name: DIName.debug.rawValue)
        else {
            fatalError("Problem with register UserRepository with named dependencies")
        }
        return UserRepository(networkService: networkService, databaseService: databaseService)
    }

    if let releaseUserRepository = container.resolve(UserRepository.self, name: DIName.release.rawValue) {
        releaseUserRepository.updateUserData()
    }

    if let debugUserRepository = container.resolve(UserRepository.self, name: DIName.debug.rawValue) {
        debugUserRepository.updateUserData()
    }
}

func singletonScopeDI() {
    let container = Container()

    container.register(NetworkService.self) { _ in NetworkServiceImpl() }
    container.register(DatabaseService.self) { _ in ReleaseDatabaseServiceImpl() }

    container.register(UserRepository.self) { resolver in
        guard let networkService = resolver.resolve(NetworkService.self),
              let databaseService = resolver.resolve(DatabaseService.self)
        else {
            fatalError("Problem with register UserRepository with Singleton scope")
        }
        return UserRepository(networkService: networkService, databaseService: databaseService)
    }.inObjectScope(.container)

    guard let userRepository1 = container.resolve(UserRepository.self) else { return }
    userRepository1.updateUserData()

    guard let userRepository2 = container.resolve(UserRepository.self) else { return }
    let areSame = userRepository1 === userRepository2
    print("Are the two UserRepository objects the same (Singleton Scope)? \(areSame.toEmoji)")
}

func main() {
    print("Running Factory Method DI:")
    factoryMethodDI()

    print("\nRunning Named Dependencies DI:")
    namedDependenciesDI()

    print("\nRunning Singleton Scope DI:")
    singletonScopeDI()
}

main()

extension Bool {
    var toEmoji: String { self ? "✅" : "❌" }
}
