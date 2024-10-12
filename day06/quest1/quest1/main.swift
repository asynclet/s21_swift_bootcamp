import Foundation
import RealmSwift

// Warning: Using only swift 5, or support Sendable for Recipe and create DTO copy

final class Recipe: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String = ""
    @Persisted var instructions: String = ""
    @Persisted var imageURL: String = ""
}

let config = Realm.Configuration(
    schemaVersion: 1,
    migrationBlock: { migration, oldSchemaVersion in
        if oldSchemaVersion < 1 {
            // We don't need migration
        }
    }
)

Realm.Configuration.defaultConfiguration = config

final actor RecipeDataSource {
    private let realm: Realm

    init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Ошибка инициализации Realm: \(error.localizedDescription)")
        }
    }

    func createRecipe(title: String, instructions: String, imageURL: String) async {
        let recipe = Recipe()
        recipe.title = title
        recipe.instructions = instructions
        recipe.imageURL = imageURL

        do {
            try realm.write {
                realm.add(recipe)
            }
        } catch {
            print("Ошибка при создании рецепта: \(error.localizedDescription)")
        }
    }

    func readRecipe() -> [Recipe] {
        Array(realm.objects(Recipe.self))
    }

    func updateRecipe(id: ObjectId, newTitle: String, newInstructions: String, newImageURL: String) async {
        guard let recipe = realm.object(ofType: Recipe.self, forPrimaryKey: id) else { return }

        do {
            try realm.write {
                recipe.title = newTitle
                recipe.instructions = newInstructions
                recipe.imageURL = newImageURL
            }
        } catch {
            print("Ошибка при обновлении рецепта: \(error.localizedDescription)")
        }
    }

    func deleteRecipe(id: ObjectId) async {
        guard let recipe = realm.object(ofType: Recipe.self, forPrimaryKey: id) else { return }

        do {
            try realm.write {
                realm.delete(recipe)
            }
        } catch {
            print("Ошибка при удалении рецепта: \(error.localizedDescription)")
        }
    }

    func searchRecipe(title: String) -> [Recipe] {
        let result = realm.objects(Recipe.self).filter("title CONTAINS[cd] %@", title)
        return Array(result)
    }
}

let dataSource = RecipeDataSource()

// MARK: - Example

Task {
    await dataSource.createRecipe(
        title: "Example1",
        instructions: "Example1 instructions",
        imageURL: "url")

    await dataSource.createRecipe(
        title: "Example2",
        instructions: "Example2 instructions",
        imageURL: "url"
    )

    let recipes = await dataSource.readRecipe()
    print("List:")
    recipes.forEach { recipe in
        print("\(recipe.title) - \(recipe.instructions) [\(recipe.imageURL)]")
    }

    if let firstRecipe = recipes.first {
        await dataSource.deleteRecipe(id: firstRecipe.id)
    }

    print("\nDeleted first element:")
    let updatedRecipes = await dataSource.readRecipe()
    updatedRecipes.forEach { recipe in
        print("\(recipe.title) - \(recipe.instructions) [\(recipe.imageURL)]")
    }

    if let firstRecipe = updatedRecipes.first {
        await dataSource.updateRecipe(
            id: firstRecipe.id,
            newTitle: "newTitle",
            newInstructions: "newInstructions",
            newImageURL: "newImageURL"
        )
    }

    let searchResults = await dataSource.searchRecipe(
        title: "newTitle"
    )
    print("\nResults:")
    searchResults.forEach { recipe in
        print("\(recipe.title) - \(recipe.instructions) [\(recipe.imageURL)]")
    }
}
