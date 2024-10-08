import Foundation
import quest1

// Function to calculate the distance from the zone to the accident

enum CoordinatesType: Int {
    case circle = 2
    case triangular = 3
    case quadrangular = 4

    var stringValue: String {
        switch self {
        case .circle:
            return "circle"
        case .triangular:
            return "triangular"
        case .quadrangular:
            return "quadrangular"
        }
    }
}

class City {
    let name: String
    let commonPhoneNumber: String
    let zones: [RescueZone]

    init(name: String, commonPhoneNumber: String, zones: [RescueZone]) {
        self.name = name
        self.commonPhoneNumber = commonPhoneNumber
        self.zones = zones
    }

    // Function to find if accident coordinates are inside any zone
    func findZoneForAccident(accidentCoordinates: (x: Int, y: Int)) -> RescueZone? {
        for zone in zones {
            if zone.isAccidentInZone(accidentCoordinates: accidentCoordinates) {
                return zone
            }
        }
        return nil
    }

    // Function to find the nearest zone if accident is outside of all zones
    func findNearestZone(accidentCoordinates: (x: Int, y: Int)) -> RescueZone {
        return zones.min(by: { $0.distanceToAccident(accidentCoordinates: accidentCoordinates) < $1.distanceToAccident(accidentCoordinates: accidentCoordinates) })!
    }
}

extension RescueZone {
    func distanceToAccident(accidentCoordinates: (x: Int, y: Int)) -> Double {
        let centerX = coordinates.reduce(0) { $0 + $1.x } / coordinates.count
        let centerY = coordinates.reduce(0) { $0 + $1.y } / coordinates.count
        let deltaX = Double(accidentCoordinates.x - centerX)
        let deltaY = Double(accidentCoordinates.y - centerY)
        return sqrt(deltaX * deltaX + deltaY * deltaY)
    }
}

class CityService {

    private let city: City

    init(city: City) {
        self.city = city
    }

    // Function to input accident coordinates
    func inputAccidentCoordinates() -> (x: Int, y: Int)? {
        print("Enter accident coordinates:")
        guard let accidentCoordinatesInput = readLine(), !accidentCoordinatesInput.isEmpty else {
            print("Error: Invalid input for accident coordinates.")
            return nil
        }

        let accidentCoordinatesParts = accidentCoordinatesInput.split(separator: ";")
        guard accidentCoordinatesParts.count == 2,
              let accidentX = Int(accidentCoordinatesParts[0]),
              let accidentY = Int(accidentCoordinatesParts[1]) else {
            print("Error: Invalid format for accident coordinates.")
            return nil
        }

        return (x: accidentX, y: accidentY)
    }

    // Function to process the accident based on coordinates only
    func processAccident() {
        guard let accidentCoordinates = inputAccidentCoordinates() else {
            print("Error entering accident data. Terminating.")
            return
        }

        let nearestZone = city.findNearestZone(accidentCoordinates: accidentCoordinates)
        print("\nThe accident didn't match any zone. The nearest zone: \(nearestZone.name)")
        print(
        """
            The zone info:
            The shape of area: \(String(describing: CoordinatesType(rawValue: nearestZone.coordinates.count)?.stringValue))
            Phone number: \(nearestZone.phoneNumber)
            Name: Sovetsky \(nearestZone.name)
            Emergency dept: \(nearestZone.emergencyDeptCode)
            Danger level: \(nearestZone.dangerLevel.rawValue)
        """
        )
    }
}

// Helper function to create the City with predefined zones
func createCity() -> City {
    let sovetskyDistrict = RescueZone(
        name: "Sovetsky district",
        phoneNumber: "+7 934 736-28-26",
        emergencyDeptCode: "49324",
        dangerLevel: .low,
        coordinates: [(7, 7), (7, 1)]
    )

    let kalininskyDistrict = RescueZone(
        name: "Kalininsky district",
        phoneNumber: "+7 934 736-28-27",
        emergencyDeptCode: "49325",
        dangerLevel: .medium,
        coordinates: [(11, 11), (12, 12), (12, 11)]
    )

    let kirovskyDistrict = RescueZone(
        name: "Kirovsky district",
        phoneNumber: "+7 934 736-28-28",
        emergencyDeptCode: "49326",
        dangerLevel: .high,
        coordinates: [(0, 0), (0, -2), (-2, 0), (-1, 1)]
    )

    return City(
        name: "Novosibirsk",
        commonPhoneNumber: "8 (800) 847 38 24",
        zones: [sovetskyDistrict, kalininskyDistrict, kirovskyDistrict]
    )
}

// Main Function
func main() {
    let city = createCity()
    let cityService = CityService(city: city)
    cityService.processAccident()
}

main()
