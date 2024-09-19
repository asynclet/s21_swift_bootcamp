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
    // Collect coordinates
    for key in coordinates.keys {
        getCoordinate(for: key)
    }

    guard let x1 = coordinates["x1"] ?? 0.0,
          let y1 = coordinates["y1"] ?? 0.0,
          let r1 = coordinates["r1"] ?? 0.0,
          let x2 = coordinates["x2"] ?? 0.0,
          let y2 = coordinates["y2"] ?? 0.0,
          let r2 = coordinates["r2"] ?? 0.0
    else {
        print("Error in input.")
        return
    }

    let distance = sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2))
    let radiusSum = r1 + r2
    let radiusDiff = abs(r1 - r2)

    if distance < radiusDiff {
        print("One circle is inside another")
    } else if distance == radiusDiff || distance == radiusSum {
        print("The circles intersect")
        if let point = intersectionPoints(x1: x1, y1: y1, r1: r1, x2: x2, y2: y2, r2: r2).first {
            print("[[\(point.0), \(point.1)]]")
        }
    } else if distance < radiusSum {
        print("The circles intersect")
        let points = intersectionPoints(x1: x1, y1: y1, r1: r1, x2: x2, y2: y2, r2: r2)
        print("[ [\(points[0].0), \(points[0].1)], [\(points[1].0), \(points[1].1)] ]")
    } else {
        print("The circles do not intersect")
    }
}

func getCoordinate(for key: String) {
    while true {
        print("Input \(key): ", terminator: "")
        if let input = readLine(), let value = Double(input) {
            coordinates[key] = value
            break
        } else {
            print("Couldn't parse a number. Please try again.")
        }
    }
}

func intersectionPoints(x1: Double, y1: Double, r1: Double, x2: Double, y2: Double, r2: Double) -> [(Double, Double)] {
    let d = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2))

    // Finding the two points of intersection using geometric formulas
    let a = (pow(r1, 2) - pow(r2, 2) + pow(d, 2)) / (2 * d)
    let h = sqrt(pow(r1, 2) - pow(a, 2))

    let x0 = x1 + a * (x2 - x1) / d
    let y0 = y1 + a * (y2 - y1) / d

    let rx = -(y2 - y1) * (h / d)
    let ry = (x2 - x1) * (h / d)

    let intersection1 = (x0 + rx, y0 + ry)
    let intersection2 = (x0 - rx, y0 - ry)

    return [intersection1, intersection2]
}

// MARK: - Main Program Execution

main()
