import Foundation

struct Ingredient: Codable, Hashable {
    let id: Int
    let name: String
    let image: String
    
    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.image == rhs.image
    }
}

struct Step: Codable, Hashable {
    let number: Int
    let step: String
    let ingredients: [Ingredient]
    
    static func == (lhs: Step, rhs: Step) -> Bool {
        lhs.number == rhs.number &&
        lhs.step == rhs.step &&
        lhs.ingredients == rhs.ingredients
    }
}

struct Instruction: Codable, Hashable {
    let steps: [Step]
    
    static func == (lhs: Instruction, rhs: Instruction) -> Bool {
        lhs.steps == rhs.steps
    }
}

struct RecipeInstructionsResponse: Codable {
    let instructions: [Instruction]
}
