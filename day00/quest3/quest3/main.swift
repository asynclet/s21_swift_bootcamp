import Foundation
import Day00Common

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

        let comfortableRange = season.range

        let displayedTemp = currentTemp.converted(to: scale)
        print("The temperature is \(formatter.string(from: displayedTemp))")

        let minComfortable = comfortableRange.min.converted(to: scale)
        let maxComfortable = comfortableRange.max.converted(to: scale)
        print("The comfortable temperature is from \(formatter.string(from: minComfortable)) to \(formatter.string(from: maxComfortable)).")

        let comfortMessage = measurementManager.checkComfortability(temp: currentTemp, range: comfortableRange, formatter: formatter)
        print(comfortMessage)

    } catch {
        print("Incorrect input. Please try again.")
        main()
    }
}

// MARK: - Main Program Execution

main()
