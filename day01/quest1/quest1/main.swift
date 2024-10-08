import Foundation

func readInput(prompt: String, isZone: Bool) -> String? {
    print(prompt)
    guard let input = readLine() else {
        print("Error: Invalid input for \(isZone ? "zone info" : "accident description").")
        return nil
    }
    return input
}

func inputZone() -> RescueZone? {
    print("Enter zone parameters:")
    guard let coordinatesInput = readLine(), !coordinatesInput.isEmpty else {
        print("Error: Invalid input for coordinates.")
        return nil
    }

    let allCoordinates = coordinatesInput.split(separator: " ")

    guard allCoordinates.count <= 5 &&  allCoordinates.count > 1 else {
        print("Error: Invalid input for coordinates.")
        return nil
    }

    let coordinates = allCoordinates.compactMap { coordString -> (Int, Int)? in
        let values = coordString.split(separator: ";")
        guard values.count == 2,
              let x = Int(values[0]),
              let y = Int(values[1]) else {
            return nil
        }
        return (x, y)
    }

    if coordinates.isEmpty {
        print("Error: Invalid coordinate format.")
        return nil
    }

    print("\nEnter the zone info:")
    guard let phoneNumber = readInput(prompt: "Enter phone number:", isZone: true),
          let name = readInput(prompt: "Enter name:", isZone: true),
          let emergencyDeptCode = readInput(prompt: "Enter emergency dept:", isZone: true)
    else {
        return nil
    }

    print("Enter danger level:")
    guard let dangerLevelInput = readLine()?.lowercased(),
          let dangerLevel = DangerLevel(rawValue: dangerLevelInput)
    else {
        print("Error: Invalid input for danger level.")
        return nil
    }

    return RescueZone(
        name: name,
        phoneNumber: phoneNumber,
        emergencyDeptCode: emergencyDeptCode,
        dangerLevel: dangerLevel,
        coordinates: coordinates
    )
}

func inputAccident() -> Accident? {
    print("\n Enter an accident coordinates:")
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

    print("\nEnter the accident info:")
    let description = readInput(prompt: "Enter description:", isZone: false)
    let applicantNumber = readLine()

    print("Enter accident type:")
    let accidentTypeInput = readLine()?.lowercased()

    guard let description else {
        return nil
    }

    return Accident(
        coordinates: (x: accidentX, y: accidentY),
        description: description,
        applicantNumber: applicantNumber,
        type: accidentTypeInput
    )
}

func rescueService() {
    guard let zone = inputZone() else {
        print("Error entering zone data. Terminating.")
        return
    }

    guard let accident = inputAccident() else {
        print("Error entering accident data. Terminating.")
        return
    }

    print("\n")

    if zone.isAccidentInZone(accidentCoordinates: accident.coordinates) {
        print("An accident is in \(zone.name).")
        print("Applicant number: \(accident.applicantNumber ?? "N/A")")
        print("Accident type: \(accident.type ?? "")")
    } else {
        print("An accident is not in \(zone.name).")
        print("Switch the applicant to the common number: 88008473824")
    }
}

rescueService()
