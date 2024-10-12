import Foundation

public struct FlightDTO: Sendable, Decodable {

    let flightNumber: String
    let departureTime: String
    let arrivalTime: String
    let origin: String
    let destination: String
    let airline: String
    let status: String
    let aircraftType: String
    let gate: String?
    let terminal: String?
    let duration: Int

    public init?(json: [String: Any]) {
        guard
            let flightNumber = json["flightNumber"] as? String,
            let departureTime = json["departureTime"] as? String,
            let arrivalTime = json["arrivalTime"] as? String,
            let origin = json["origin"] as? String,
            let destination = json["destination"] as? String,
            let airline = json["airline"] as? String,
            let status = json["status"] as? String,
            let aircraftType = json["aircraftType"] as? String,
            let duration = json["duration"] as? Int
        else {
            return nil
        }

        self.flightNumber = flightNumber
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.origin = origin
        self.destination = destination
        self.airline = airline
        self.status = status
        self.aircraftType = aircraftType
        self.gate = json["gate"] as? String
        self.terminal = json["terminal"] as? String
        self.duration = duration
    }
    
}
