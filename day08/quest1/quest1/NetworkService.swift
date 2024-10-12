import Foundation

public protocol NetworkService {
    func getUsers() -> [User]
}

final class NetworkServiceImpl: NetworkService {
    func getUsers() -> [User] {
        return [
            User(id: 1, name: "Alice", email: "alice@example.com", age: 25),
            User(id: 2, name: "Bob", email: "bob@example.com", age: 30),
            User(id: 3, name: "Charlie", email: "charlie@example.com", age: 22)
        ]
    }
}
