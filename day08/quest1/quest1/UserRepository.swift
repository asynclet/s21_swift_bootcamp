final class UserRepository {

    init(networkService: NetworkService, databaseService: DatabaseService) {
        self.networkService = networkService
        self.databaseService = databaseService
    }

    func updateUserData() {
        let users = networkService.getUsers()

        databaseService.saveUsers(users)
    }

    // MARK: - Private Properties

    private let networkService: NetworkService
    private let databaseService: DatabaseService
}
