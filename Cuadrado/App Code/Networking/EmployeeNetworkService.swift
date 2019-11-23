import Foundation

protocol EmployeeNetworkServiceProtocol {
    func getEmployees(completionHandler: @escaping (Result<[Employee], APIClientError>) -> Void)
}
 
class EmployeeNetworkService {
    func getEmployees(completionHandler: @escaping (Result<[Employee], APIClientError>) -> Void) {
        
    }
}
