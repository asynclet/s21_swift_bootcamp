import Foundation
import quest2

protocol PlayerAction {
    func findOpponent() -> Profile?
}

enum Status {
    case inPlay
    case search
    case idle
    case offline
}

class Server: PlayerAction {
    func findOpponent() -> Profile? {
        for now in gamers {
            if now.status == .search { return now }
        }
        return nil
    }

    var adress: String
    var gamers: [Profile]

    init(adress: String = "default", gamers: [Profile] = []) {
        self.adress = adress
        self.gamers = gamers
    }
}

class Profile {
    var id: UUID
    var nickname: String
    var age: Int
    var name: String
    var rev: Revolver
    let profileCreatingDate: String
    var status: Status
    lazy var reference = {
        return "http://gameserver.com/\(id)-\(nickname)"
    }()
    var playerActionDelegate: PlayerAction?

    init(id: UUID = UUID(), nickname: String = "ilyansky", age: Int = 131, name: String = "Ilya", rev: Revolver = Revolver(), profileCreatingDate: String = "01.01.1001", status: Status = .offline) {
        self.id = id
        self.nickname = nickname
        self.age = age
        self.name = name
        self.rev = rev
        self.profileCreatingDate = profileCreatingDate
        self.status = status
    }

    func changeStatus(newStatus: Status) {
        self.status = newStatus
    }
}

var p1 = Profile(status: .idle)
var p2 = Profile(status: .inPlay)
var p3 = Profile(status: .offline)
var p4 = Profile(status: .search)
var myp = Profile(status: .idle)
var s = Server(gamers: [p1, p2, p3, p4, myp])

p1.playerActionDelegate = s
p2.playerActionDelegate = s
p3.playerActionDelegate = s
p4.playerActionDelegate = s
myp.playerActionDelegate = s

print(myp.status)
print(p4.status)
print()

myp.changeStatus(newStatus: .search)
if let opponent = myp.playerActionDelegate?.findOpponent() {
    opponent.changeStatus(newStatus: .inPlay)
    myp.changeStatus(newStatus: .inPlay)
    print("Opponent has been searched\n")
} else {
    print("There is no opponent in search right now\n")
}

print(myp.status)
print(p4.status)
