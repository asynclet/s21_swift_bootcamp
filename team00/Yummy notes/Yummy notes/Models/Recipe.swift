import SwiftUI

struct Recipe: Identifiable, Codable {
    let id: Int
    var imageUrl: String?
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "image"
        case title
    }
}

struct RecipeResponse<T: Codable>: Codable {
    let results: [T]
}
