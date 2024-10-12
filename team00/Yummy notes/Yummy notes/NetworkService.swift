import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    
    // MARK: - Internal Methods
    
    func loadList() async -> Result<[Recipe], Error> {
        let queryItems = [
            URLQueryItem(name: "diet", value: "ketogenic"),
            URLQueryItem(name: "number", value: "50")
        ]
        
        do {
            let request = try createRequest(for: .complexSearch, queryItems: queryItems)
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(RecipeResponse<Recipe>.self, from: data)
            return .success(response.results)
        } catch {
            return .failure(error)
        }
    }
    
    func loadSteps(for recipeId: Int) async -> Result<[Step], Error> {
        
        do {
            let request = try createRequest(for: .analyzedInstructions(recipeId: recipeId))
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode([Instruction].self, from: data).first?.steps
            
            return .success(response ?? [])
            
        } catch {
            return .failure(error)
        }
    }
    
    // MARK: - Private Methods
    
    private func createRequest(for method: Method, queryItems: [URLQueryItem]? = nil) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        urlComponents.path = method.path
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        return request
    }
    
    // MARK: - Private Types
    
    private enum Method {
        case complexSearch
        case analyzedInstructions(recipeId: Int)
        
        var path: String {
            switch self {
            case .complexSearch:
                return "/recipes/complexSearch"
            case .analyzedInstructions(let recipeId):
                return "/recipes/\(recipeId)/analyzedInstructions"
            }
        }
    }
    
    // MARK: - Private Properties
    
    private let apiKey = "YOUR_TOKEN" // from https://spoonacular.com/food-api/
    private let baseURL = "https://api.spoonacular.com"
}
