import Foundation
import OrderedCollections

var coordinates: OrderedDictionary<String, Double?> = [
    "x1": nil,
    "y1": nil,
    "r1": nil,
    "x2": nil,
    "y2": nil,
    "r2": nil
]

func main() {
    coordinates.forEach { coordinate in
        getCoordinate(for: coordinate.key)

        while coordinates[coordinate.key] == nil {
            print("Couldn't parse a number. Please try again")
            getCoordinate(for: coordinate.key)
        }
    }

    guard let x1: Double = coordinates["x1"] ?? 0.0,
          let y1: Double = coordinates["y1"] ?? 0.0,
          let r1: Double = coordinates["r1"] ?? 0.0,
          let x2: Double = coordinates["x2"] ?? 0.0,
          let y2: Double = coordinates["y2"] ?? 0.0,
          let r2: Double = coordinates["r2"] ?? 0.0
    else {
        return
    }


    let destination = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))

    if destination <= (r1 - r2) || destination <= (r2 - r1) {
        print("One circle is inside another")
    } else if destination <= (r1 + r2) {
        print("The circles intersect")
    } else {
        print("The circles is not intersect")
    }
}

func getCoordinate(for key: String) {
    print("Input \(key):")
    guard let input = readLine() else { return }
    coordinates[key] = Double(input)
}

// MARK: - Main Program Execution

main()
