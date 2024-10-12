import Foundation

extension Int {
    func toEmoji() -> String {
        let emojiNumbers: [Character: String] = [
            "0": "0️⃣",
            "1": "1️⃣",
            "2": "2️⃣",
            "3": "3️⃣",
            "4": "4️⃣",
            "5": "5️⃣",
            "6": "6️⃣",
            "7": "7️⃣",
            "8": "8️⃣",
            "9": "9️⃣"
        ]
        
        let numberString = String(self)
        return numberString.map { emojiNumbers[$0] ?? "🔪" }.joined()
    }
}
