import Foundation

public enum Season: String {
    case winter = "w"
    case summer = "s"

    init?(_ rawValue: String?) {
        guard
            let rawValue,
            let s = Season(rawValue: rawValue)
        else { return nil }
        self = s
    }

    public var range: (min: Measurement<UnitTemperature>, max: Measurement<UnitTemperature>) {
        switch self {
        case .winter:
            (min: Measurement(value: 20, unit: UnitTemperature.celsius), max: Measurement(value: 22, unit: UnitTemperature.celsius))
        case .summer:
            (min: Measurement(value: 22, unit: UnitTemperature.celsius), max: Measurement(value: 25, unit: UnitTemperature.celsius))
        }
    }
}
