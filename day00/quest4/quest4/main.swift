import Foundation
import Day00Common

// MARK: - Humidity Extension

extension Season {
    var humidityRange: (min: Double, max: Double) {
        switch self {
        case .winter:
            return (min: 30.0, max: 45.0)
        case .summer:
            return (min: 30.0, max: 60.0)
        }
    }
}

// MARK: - Humidity Extension

extension MeasurementManagerImpl {

    func getHumidityInput() throws -> Double {
        print("Enter the current humidity percentage:")
        guard let input = readLine(), let humidity = Double(input), humidity >= 0, humidity <= 100 else {
            throw TemperatureError.invalidInput
        }
        return humidity
    }

    func checkHumidityComfortability(humidity: Double, range: (min: Double, max: Double)) -> String {
        if humidity < range.min {
            return "Please, increase the humidity by \((range.min - humidity).formatted(.number))%."
        } else if humidity > range.max {
            return "Please, decrease the humidity by \((humidity - range.max).formatted(.number))%."
        } else {
            return "The humidity is comfortable"
        }
    }

}

func main() {
    // You can implement your own formatter for more correct output
    let formatter = MeasurementFormatter()
    formatter.unitStyle = .medium
    formatter.unitOptions = .providedUnit
    formatter.numberFormatter.maximumFractionDigits = 1

    let measurementManager = MeasurementManagerImpl()

    do {
        let scale = try measurementManager.getScaleInput()
        let season = try measurementManager.getSeasonInput()
        let currentTemp = try measurementManager.getTemperatureInput(for: scale)
        let currentHumidity = try measurementManager.getHumidityInput()

        let comfortableRange = season.range

        let displayedTemp = currentTemp.converted(to: scale)
        print("The temperature is \(formatter.string(from: displayedTemp))")

        // Check temperature comfortability
        let minComfortable = comfortableRange.min.converted(to: scale)
        let maxComfortable = comfortableRange.max.converted(to: scale)
        print("The comfortable temperature is from \(formatter.string(from: minComfortable)) to \(formatter.string(from: maxComfortable)).")

        let comfortMessage = measurementManager.checkComfortability(temp: currentTemp, range: comfortableRange, formatter: formatter)
        print(comfortMessage)

        // Check humidity comfortability
        let comfortableHumidityRange = season.humidityRange
        print("The comfortable humidity is from \(comfortableHumidityRange.min.formatted(.number))% to \(comfortableHumidityRange.max.formatted(.number))%.")
        let humidityComfortMessage = measurementManager.checkHumidityComfortability(humidity: currentHumidity, range: comfortableHumidityRange)
        print(humidityComfortMessage)

    } catch {
        print("Incorrect input. Please try again.")
        main()
    }
}

// MARK: - Main Program Execution

main()
