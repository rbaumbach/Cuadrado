import Foundation

protocol EmployeeNetworkServiceProtocol {
    func getEmployees(completionHandler: @escaping (Result<[Employee], APIClientError>) -> Void)
}
 
class EmployeeNetworkService {
    // MARK: - Private properties
    
    private let apiClient: APIClientProtocol
    
    // MARK: - Init method
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public methods
    
    func getEmployees(completionHandler: @escaping (Result<[Employee], APIClientError>) -> Void) {
        
    }
}
