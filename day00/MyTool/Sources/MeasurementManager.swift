import Foundation

public protocol MeasurementManager {
    func getTemperatureInput(for unit: UnitTemperature) throws -> Measurement<UnitTemperature>
    func getScaleInput() throws -> UnitTemperature
    func checkComfortability(
        temp: Measurement<UnitTemperature>,
        range: (min: Measurement<UnitTemperature>, max: Measurement<UnitTemperature>),
        formatter: MeasurementFormatter
    ) -> String
}

public final class MeasurementManagerImpl: MeasurementManager {

    public init() {}

    public func getTemperatureInput(for unit: UnitTemperature) throws -> Measurement<UnitTemperature> {
        print("Enter the current temperature in Celsius:")

        guard let input = readLine(), let temp = Double(input) else {
            throw TemperatureError.invalidInput
        }
        return Measurement(value: temp, unit: UnitTemperature.celsius).converted(to: unit)
    }

    public func getScaleInput() throws -> UnitTemperature {
        print("Enter the temperature scale Celsius, Kelvin, Fahrenheit:")

        guard let scale = Temperature(readLine()?.lowercased())?.convertToUnitTemperature() else {
            throw TemperatureError.invalidInput
        }

        return scale
    }

    public func getSeasonInput() throws -> Season {
        print("Enter the season S for summer, W for winter:")
        guard let season = Season(readLine()?.lowercased()) else {
            throw TemperatureError.invalidInput
        }
        return season
    }

    public func checkComfortability(
        temp: Measurement<UnitTemperature>,
        range: (min: Measurement<UnitTemperature>, max: Measurement<UnitTemperature>),
        formatter: MeasurementFormatter
    ) -> String {

        formatter.unitStyle = .short
        let additionalText = temp.unit === UnitTemperature.celsius ? " degrees." : "."

        let lowerComfort = range.min.converted(to: temp.unit).value
        let upperComfort = range.max.converted(to: temp.unit).value

        if temp.value < lowerComfort {
            let diff = Measurement(value: lowerComfort - temp.value, unit: temp.unit)
            return "Please, make it warmer by \(formatter.string(from: diff))\(additionalText)"
        } else if temp.value > upperComfort {
            let diff = Measurement(value: temp.value - upperComfort, unit: temp.unit)
            return "Please, make it cooler by \(formatter.string(from: diff))\(additionalText)"
        } else {
            return "The temperature is comfortable."
        }
    }

}
