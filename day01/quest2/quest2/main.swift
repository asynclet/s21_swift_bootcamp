import Foundation

enum PhoneNumberConstants {
    static let tollFreePrefix = "8800"
    static let plusTollFreePrefix = "+7800"
    static let russianPrefix = "7"
    static let eightPrefix = "8"
    static let minPhoneNumberLength = 11
    static let fullPhoneNumberLength = 12
}

enum PhoneNumberType {
    case tollFree
    case russianStandard
    case unknown
}

enum PhoneNumberMask: String {
    case tollFree = "* (***) *** ** **"
    case russianStandard = "+7 *** ***-**-**"
    case `default` = "+* *** ***-**-**"
}

extension String {

    func detectPhoneNumberType() -> PhoneNumberType {
        let cleanedPhoneNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        if cleanedPhoneNumber.hasPrefix(PhoneNumberConstants.tollFreePrefix) || cleanedPhoneNumber.hasPrefix(PhoneNumberConstants.plusTollFreePrefix) {
            return .tollFree
        } else if cleanedPhoneNumber.hasPrefix(PhoneNumberConstants.russianPrefix) || cleanedPhoneNumber.hasPrefix(PhoneNumberConstants.eightPrefix) {
            return .russianStandard
        } else {
            return .unknown
        }
    }

    func applyPhoneMask() -> String {
        var cleanedPhoneNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        // Ensure the phone number is at least 11 digits
        guard cleanedPhoneNumber.count >= PhoneNumberConstants.minPhoneNumberLength else { return self }

        let phoneType = self.detectPhoneNumberType()
        let firstDigit = cleanedPhoneNumber.prefix(1)

        // Handle the case for an 11-digit phone number
        if cleanedPhoneNumber.count == PhoneNumberConstants.minPhoneNumberLength {
            if cleanedPhoneNumber.hasPrefix(PhoneNumberConstants.tollFreePrefix) {
                // Toll-free numbers starting with 8800
                return cleanedPhoneNumber.applyMask(mask: .tollFree)
            }
            if firstDigit == PhoneNumberConstants.eightPrefix {
                cleanedPhoneNumber.removeFirst()
                return applyCorrectMask(cleanedPhoneNumber, phoneType: phoneType, defaultMask: .russianStandard)
            }
            if firstDigit == PhoneNumberConstants.russianPrefix {
                cleanedPhoneNumber.removeFirst()
                return applyCorrectMask(cleanedPhoneNumber, phoneType: phoneType, defaultMask: .default)
            }
        }

        // Handle the case for a 12-digit phone number with a Russian standard prefix
        if cleanedPhoneNumber.count == PhoneNumberConstants.fullPhoneNumberLength && phoneType == .russianStandard {
            cleanedPhoneNumber.removeFirst(2)
            return applyCorrectMask(cleanedPhoneNumber, phoneType: phoneType, defaultMask: .russianStandard)
        }

        return self
    }

    // Helper function to apply the appropriate mask based on the phone type
    private func applyCorrectMask(_ cleanedPhoneNumber: String, phoneType: PhoneNumberType, defaultMask: PhoneNumberMask) -> String {
        switch phoneType {
        case .tollFree:
            return cleanedPhoneNumber.applyMask(mask: .tollFree)
        case .russianStandard:
            return cleanedPhoneNumber.applyMask(mask: .russianStandard)
        case .unknown:
            return cleanedPhoneNumber.applyMask(mask: defaultMask)
        }
    }

    func applyMask(mask: PhoneNumberMask) -> String {
        var result = ""
        var phoneIndex = self.startIndex
        let maskString = mask.rawValue

        for char in maskString {
            if char == "*", phoneIndex < self.endIndex {
                result.append(self[phoneIndex])
                phoneIndex = self.index(after: phoneIndex)
            } else {
                result.append(char)
            }
        }
        return result
    }
}

let phone = readLine() ?? ""
print(phone.applyPhoneMask())
