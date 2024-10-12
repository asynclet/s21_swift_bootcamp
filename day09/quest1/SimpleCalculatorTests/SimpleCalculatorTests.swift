import XCTest
@testable import quest1

final class SimpleCalculatorTests: XCTestCase {

    let calculator = SimpleCalculator()

    func testCircleArea() {
        print("Start tests for circleArea method 🛰️")
        XCTAssertEqual(calculator.circleArea(radius: 0), 0)
        XCTAssertEqual(calculator.circleArea(radius: 1), 3.14)
        XCTAssertEqual(calculator.circleArea(radius: 2.5), 3.14 * 2.5 * 2.5, accuracy: 0.001)
        print("Finish tests for circleArea method 🏁")
    }

    func testFibonacci() {
        print("Start tests for fibonacci method 🛰️")
        XCTAssertEqual(calculator.fibonacci(n: 0), 0)
        XCTAssertEqual(calculator.fibonacci(n: 1), 1)
        XCTAssertEqual(calculator.fibonacci(n: 2), 1)
        XCTAssertEqual(calculator.fibonacci(n: 3), 2)
        XCTAssertEqual(calculator.fibonacci(n: 5), 5)
        XCTAssertEqual(calculator.fibonacci(n: 6), 8)
        XCTAssertEqual(calculator.fibonacci(n: 10), 55)
        print("Finish tests for fibonacci method 🏁")
    }

    func testFahrenheit() {
        print("Start tests for fahrenheit method 🛰️")
        XCTAssertEqual(calculator.fahrenheit(celcius: 0), -32)
        XCTAssertEqual(calculator.fahrenheit(celcius: 100), 148)
        XCTAssertEqual(calculator.fahrenheit(celcius: -40), -104)
        print("Finish tests for fahrenheit method 🏁")
    }

    func testIsEven() {
        print("Start tests for isEven method 🛰️")
        XCTAssertTrue(calculator.isEven(num: 3))
        XCTAssertFalse(calculator.isEven(num: 2))
        XCTAssertTrue(calculator.isEven(num: 17))
        XCTAssertFalse(calculator.isEven(num: 0))
        print("Finish tests for isEven method 🏁")
    }

    func testGetAvg() {
        print("Start tests for getAvg method 🛰️")
        XCTAssertNil(calculator.getAvg(numbers: []))

        XCTAssertNotNil(calculator.getAvg(numbers: [1, 2, 3]))
        XCTAssertEqual(calculator.getAvg(numbers: [1, 2, 3]), 2)
        XCTAssertEqual(calculator.getAvg(numbers: [10, 20, 30, 40]), 25)

        XCTAssertEqual(calculator.getAvg(numbers: [5]), 5)
        print("Finish tests for getAvg method 🏁")
    }
}
