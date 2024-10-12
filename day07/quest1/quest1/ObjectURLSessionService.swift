import Foundation

final class ObjectURLSessionService: IObjectService {
    var baseURL: String = "https://api.example.com/flights"

    func fetchFlightList(completion: @Sendable @escaping ([FlightDTO]?) -> Void) {
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    print("Received response: \(jsonArray)")

                    let flightList = jsonArray.compactMap { FlightDTO(json: $0) }
                    completion(flightList)
                } else {
                    print("Invalid JSON format")
                    completion(nil)
                }
            } catch {
                print("Error deserializing JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }

        task.resume()
    }
}
