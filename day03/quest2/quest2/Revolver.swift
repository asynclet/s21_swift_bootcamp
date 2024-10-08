import Foundation

public final class Revolver {

    static var bulletID = [UUID]()

    let caliber: Caliber

    var clip: [Patron?]

    var pointer: Patron? {
        return clip[0]
    }

    init(caliber: Caliber = .c22) {
        self.clip = Array(repeating: nil, count: 6)
        self.caliber = caliber
    }

}

public extension Revolver {

    func add(_ bullet: Patron) -> Bool {
        if bullet.caliber != caliber || Revolver.bulletID.contains(bullet.id) { return false }

        for (i, slot) in clip.enumerated() {
            if slot == nil {
                clip[i] = bullet
                Revolver.bulletID.append(bullet.id)
                self.scroll(i)
                return true
            }
        }

        return false
    }

    func addMany(_ bullets: [Patron]) -> Bool {
        var matchPatrons = [Patron]()
        var tempPatronsID = [UUID]()
        for now in bullets {
            if now.caliber == caliber && !Revolver.bulletID.contains(now.id) && !tempPatronsID.contains(now.id) {
                tempPatronsID.append(now.id)
                matchPatrons.append(now)
            }
        }

        if matchPatrons.isEmpty { return false }

        var bulletsInt: Int = 0
        var i: Int = 0

        while i < clip.count {
            if clip[i] == nil {
                if bulletsInt < matchPatrons.count {
                    clip[i] = matchPatrons[bulletsInt]
                    Revolver.bulletID.append(matchPatrons[bulletsInt].id)
                    bulletsInt += 1
                    self.scroll(i)
                    i = 0
                }
            }
            i += 1
        }

        return true
    }

    func shoot() -> Patron? {
        if clip[0] == nil { print("Click\n") }
        else if clip[0]?.patronType == .charged { clip[0]?.shoot() }

        let newBulletsID = Revolver.bulletID.filter { $0 != clip[0]?.id }
        Revolver.bulletID = newBulletsID

        let shootedPatron = clip.removeFirst()
        clip.append(nil)

        return shootedPatron
    }

    func unload(_ index: Int) -> Patron? {
        if index < 0 || index >= clip.count { return nil }

        let newPatronsID = Revolver.bulletID.filter { $0 != clip[index]?.id }
        Revolver.bulletID = newPatronsID

        let unloadedPatron = clip.remove(at: index)
        clip.insert(nil, at: index)

        return unloadedPatron
    }

    func unloadAll() -> [Patron?] {
        let result = clip
        clip = [nil, nil, nil, nil, nil, nil]
        Revolver.bulletID.removeAll()
        return result
    }

    func scroll(_ shift: Int = Int.random(in: 1...5)) {
        var shift = shift
        if shift < 0 || shift > 6 { shift = Int.random(in: 1...5) }

        let newIndexes = [
            (0 + shift) % 6,
            (1 + shift) % 6,
            (2 + shift) % 6,
            (3 + shift) % 6,
            (4 + shift) % 6,
            (5 + shift) % 6,
        ]

        let clipCopy = clip

        for i in 0 ..< clip.count {
            clip[i] = clipCopy[newIndexes[i]]
        }
    }

    func getSize() -> Int {
        return clip.count
    }

    func countPatronsInClip() -> Int {
        var count: Int = 0
        for now in clip {
            if now != nil { count += 1 }
        }
        return count
    }

    func toStringDescription() {
        print("Class: Revolver \(caliber) caliber")

        var line = "["
        for (i, now) in clip.enumerated() {
            if now == nil && i < clip.count - 1 { line += "nil, " }
            else if now == nil && i == clip.count - 1 { line += "nil]" }
            else if now != nil && i < clip.count - 1 {
                line += "Patron(id\(findIndexOfId(now!.id)), \(now!.patronType), \(now!.caliber)), "
            } else {
                line += "Patron(id\(findIndexOfId(now!.id)), \(now!.patronType), \(now!.caliber))]"
            }
        }
        print("Objects: \(line)")
        line = ""

        let ptr = pointer
        if ptr == nil { line += "nil" }
        else {
            line += "Patron(id\(findIndexOfId(ptr!.id)), \(ptr!.patronType), \(ptr!.caliber))"
        }
        print("Pointer: \(line)\n")
    }

    private func findIndexOfId(_ id: UUID) -> Int {
        for (i, now) in Revolver.bulletID.enumerated() {
            if now == id { return i }
        }
        return 0
    }

    subscript(index: Int) -> Patron? {
        if index < 0 || index >= clip.count { fatalError("Index out of range") }
        return clip[index]
    }

}
