public protocol IObjectService {
    var baseURL: String { get }

    func fetchFlightList(completion: @Sendable @escaping ([FlightDTO]?) -> Void)
}
