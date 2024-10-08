import Foundation

public struct RescueZone {

    public init(
        name: String,
        phoneNumber: String,
        emergencyDeptCode: String,
        dangerLevel: DangerLevel,
        coordinates: [(x: Int, y: Int)]
    ) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.emergencyDeptCode = emergencyDeptCode
        self.dangerLevel = dangerLevel
        self.coordinates = coordinates
    }

    public let name: String
    public let phoneNumber: String
    public let emergencyDeptCode: String
    public let dangerLevel: DangerLevel
    public let coordinates: [(x: Int, y: Int)]

    public func isAccidentInZone(accidentCoordinates: (x: Int, y: Int)) -> Bool {
        let xCoordinates = coordinates.map { $0.x }
        let yCoordinates = coordinates.map { $0.y }

        guard let minX = xCoordinates.min(),
              let maxX = xCoordinates.max(),
              let minY = yCoordinates.min(),
              let maxY = yCoordinates.max() else {
            return false
        }

        return (accidentCoordinates.x >= minX && accidentCoordinates.x <= maxX) &&
               (accidentCoordinates.y >= minY && accidentCoordinates.y <= maxY)
    }
}
