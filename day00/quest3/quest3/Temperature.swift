import Foundation

enum Temperature: String {
    case celsius
    case kelvin
    case fahrenheit

    init?(_ rawValue: String?) {
        guard
            let rawValue,
            let temp = Temperature(rawValue: rawValue)
        else { return nil }
        self = temp
    }

    func convertToUnitTemperature() -> UnitTemperature {
        switch self {
        case .celsius:
            return UnitTemperature.celsius
        case .kelvin:
            return UnitTemperature.kelvin
        case .fahrenheit:
            return UnitTemperature.fahrenheit
        }
    }
}
