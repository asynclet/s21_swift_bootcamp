import Foundation

func p(_ rev: Revolver) {
    print(Revolver.bulletID)
    print(rev.clip)
    print()
}

func myTest() {
    let pb1 = Patron(patronType: .damp)
    let pl1 = Patron(patronType: .charged)
    let pb2 = Patron(patronType: .charged)
    let pl2 = Patron(patronType: .damp)
    let pAnotherCaliber = Patron(caliber: .c38)
    let rev = Revolver()
    var cnt = 0

    _ = rev.add(pb1)
    _ = rev.add(pb1)
    if Revolver.bulletID.count == 1 && rev.countPatronsInClip() == 1  {
        cnt += 1
    }

    _ = rev.addMany([pb1, pl1, pb2, pAnotherCaliber])
    if Revolver.bulletID.count == 3 && rev.countPatronsInClip() == 3 {
        cnt += 1
    }

    _ = rev.shoot()
    if Revolver.bulletID.count == 2 && rev.countPatronsInClip() == 2 {
        cnt += 1
    }

    _ = rev.unload(3)
    if Revolver.bulletID.count == 1 && rev.countPatronsInClip() == 1 {
        cnt += 1
    }

    _ = rev.add(pl2)
    _ = rev.unloadAll()
    if Revolver.bulletID.count == 0 && rev.countPatronsInClip() == 0 {
        cnt += 1
    }

    if cnt == 5 {
        print("myTest +")
    }
}
myTest()

func test() {
    let pd1 = Patron(patronType: .damp)
    let pc1 = Patron(patronType: .charged)
    let pc2 = Patron(patronType: .charged)
    let pd2 = Patron(patronType: .damp)
    let p = Patron()
    let pAnotherCaliber = Patron(caliber: .c38)
    let r1 = Revolver()
    let r2 = Revolver()

    _ = r1.addMany([pd1, pc1, pAnotherCaliber])
    _ = r2.addMany([pc2, pd2, pAnotherCaliber])

    print("1.1 Shoot of damp rev1")
    r1.toStringDescription()
    print("Shoot activated")
    _ = r1.shoot()
    r1.toStringDescription()

    print("1.2 Shoot of damp rev2")
    r2.toStringDescription()
    print("Shoot activated\n")
    _ = r2.shoot()
    r2.toStringDescription()

    _ = r1.unloadAll()
    _ = r2.unloadAll()
    print("2. One patron in two revolvers")
    print("rev1 = \(r1.add(p))")
    r1.toStringDescription()
    print("rev2 = \(r2.add(p))")
    r2.toStringDescription()

    _ = r1.unloadAll()
    _ = r2.unloadAll()
    let c1 = [p, pd1, pd2]
    let c2 = [p, pc1, pc2]
    print("3. Add collections to revolvers")
    print("rev1:")
    _ = r1.addMany(c1)
    r1.toStringDescription()
    print("rev2:")
    _ = r2.addMany(c2)
    r2.toStringDescription()
}

test()
