//
//  main.swift
//  quest2
//
//  Created by Anastasiia Vaganova on 14.09.2024.
//

import Foundation

enum NumberComposerError: Error {
    case invalidInput(String)
}

enum Order: String {
    case lower
    case higher

    init?(rawValue: String?) {
        guard
            let rawValue,
            let order = Order(rawValue: rawValue)
        else { return nil }
        self = order
    }
}

class NumberComposer {

    init(userNumber: Int, order: Order) throws {
        self.userNumber = userNumber
        self.order = order
    }

    func composeNumbers() {
        let absoluteNumber = abs(userNumber)
        let numberString = order == .lower ? String(String(absoluteNumber).reversed()) : String(absoluteNumber)
        let isNegative: Character? = userNumber < .zero ? Character("-") : nil

        var output: String = if let isNegative {
            String(isNegative)
        } else {
            String()
        }

        numberString.forEach { character in
            output.append(character)
            guard let intOutput = Int(output) else { return }
            print(intOutput)
        }
    }

    private var userNumber: Int
    private var order: Order

}

// MARK: - Function to get user input from command line

func getUserInput() throws {
    print("Enter the order 'higher' or 'lower':")
    guard let order = Order(rawValue: readLine()) else {
        throw NumberComposerError.invalidInput("Order must be either 'higher' or 'lower'.")
    }

    print("Enter an integer number:")
    guard let userInput = readLine(strippingNewline: true), let userNumber = Int(userInput) else {
        throw NumberComposerError.invalidInput("Failed to recognize the number. Make sure you are entering a valid integer.")
    }

    let composer = try NumberComposer(userNumber: userNumber, order: order)
    composer.composeNumbers()
}

// MARK: - Main Program Execution

do {
    try getUserInput()
} catch NumberComposerError.invalidInput(let message) {
    print("Error: \(message)")
} catch {
    print("Unexpected error: \(error)")
}

