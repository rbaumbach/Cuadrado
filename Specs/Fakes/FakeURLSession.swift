import Foundation
@testable import Cuadrado

enum FakeURLSessionError: Error {
    case whocares
}

class FakeURLSession: URLSessionProtocol {
    // MARK: - Captured properties
    
    var capturedInitConfiguration: URLSessionConfiguration
    
    var capturedURL: URL?
    var capturedCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    // MARK: - Stubbed properties
    
    var stubbedDataTask = URLSession(configuration: .default).dataTask(with: URL(string: "https://whocares.com")!)
    
    // MARK: - <URLSessionProtocol>
    
    required init(configuration: URLSessionConfiguration) {
        capturedInitConfiguration = configuration
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        capturedURL = url
        capturedCompletionHandler = completionHandler
        
        return stubbedDataTask
    }
}
