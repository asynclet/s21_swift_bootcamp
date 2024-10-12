import Foundation
import Alamofire

final class ObjectAlamofireService: IObjectService {
    var baseURL: String = "https://api.example.com/flights"

    func fetchFlightList(completion: @Sendable @escaping ([FlightDTO]?) -> Void) {
        AF.request(baseURL)
            .validate() // Ensures a valid HTTP response
            .responseDecodable(of: [FlightDTO].self) { response in
                switch response.result {
                case .success(let flightList):
                    print("Received response: \(flightList)")
                    completion(flightList)
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
                    completion(nil)
                }
            }
    }
}
