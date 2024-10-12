import Foundation

public protocol DatabaseService {
    func saveUsers(_ users: [User])
}

final class ReleaseDatabaseServiceImpl: DatabaseService {
    func saveUsers(_ users: [User]) {
        let userNames = users.map { $0.name }.joined(separator: ", ")
        print("Release: [\(userNames)] were saved")
    }
}

final class DebugDatabaseServiceImpl: DatabaseService {
    func saveUsers(_ users: [User]) {
        let userNames = users.map { $0.name }.joined(separator: ", ")
        print("Debug: [\(userNames)] were saved")
    }
}
