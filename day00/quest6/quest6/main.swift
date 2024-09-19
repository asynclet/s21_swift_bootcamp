import Foundation

// MARK: - Constants

// Dictionaries for numbers and their textual representations
let kOnes = [
    "", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
    "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen",
    "seventeen", "eighteen", "nineteen"
]

let kTens = [
    "", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"
]

let kHundred = "hundred"
let kThousand = "thousand"
let kMillion = "million"

// MARK: - Functions

/// Converts a given number into its corresponding textual representation.
///
/// - Parameter number: The number to be converted.
/// - Returns: A string representing the number in words.
func convertNumberToWords(_ number: Int) -> String {
    guard number != .zero else { return "zero" }

    var num = number
    var words = ""

    if num < 0 {
        words += "minus "
        num = abs(num)
    }

    // Convert millions
    if num >= 1_000_000 {
        words += convertNumberBelowThousand(num / 1_000_000) + " " + kMillion + " "
        num %= 1_000_000
    }

    // Convert thousands
    if num >= 1_000 {
        words += convertNumberBelowThousand(num / 1_000) + " " + kThousand + " "
        num %= 1_000
    }

    // Convert the remaining part
    if num > 0 {
        words += convertNumberBelowThousand(num)
    }

    return words.trimmingCharacters(in: .whitespacesAndNewlines)
}

/// Converts numbers less than a thousand into their corresponding textual representation.
///
/// - Parameter number: The number to be converted (less than 1000).
/// - Returns: A string representing the number in words.
func convertNumberBelowThousand(_ number: Int) -> String {
    var num = number
    var result = ""

    // Convert hundreds
    if num >= 100 {
        result += kOnes[num / 100] + " " + kHundred
        num %= 100
        if num > 0 {
            result += " and "
        }
    }

    // Convert tens
    if num >= 20 {
        result += kTens[num / 10]
        num %= 10
        if num > 0 {
            result += "-"
        }
    }

    // Convert ones
    if num > 0 {
        result += kOnes[num]
    }

    return result
}

// MARK: - Main Program

/// Runs the number-to-words program. Continuously reads user input and converts
/// the input number to words, until the user types "exit" to quit.
func runNumberToWordsProgram() {
    print("The program is running. Enter a number or type \"exit\" to stop:")

    var iterationCount = 0

    while true {
        iterationCount += 1

        // Every 5th iteration, print an additional message
        if iterationCount % 5 == 0 {
            print("Enter a number or type \"exit\" to stop:")
        } else if iterationCount > 1 {
            print("Enter a number:")
        }

        // Read user input
        guard let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            print("Incorrect format, try again.\n")
            continue
        }

        // Check if the user wants to exit
        if input.lowercased() == "exit" {
            print("Bye!")
            break
        }

        // Check if the input is a valid number
        if let number = Int(input), abs(number) <= 1_000_000 {
            let words = convertNumberToWords(number)
            print(words)
        } else {
            print("Incorrect format, try again.\n")
        }
    }
}

// MARK: - Run Program

runNumberToWordsProgram()
