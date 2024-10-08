import Foundation

public final class Patron {

    enum PatronType: Int {
        case damp = 0
        case charged = 1
    }

    let id = UUID()
    let patronType: PatronType
    let caliber: Caliber

    init(patronType: PatronType = .damp, caliber: Caliber = .c22) {
        self.patronType = patronType
        self.caliber = caliber
    }

    func shoot() {
        print("Bang")
        print("Caliber = \(caliber.rawValue)\n")
    }
}
