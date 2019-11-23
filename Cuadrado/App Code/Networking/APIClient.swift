import Foundation

struct APIClientConstants {
    static let baseURLString = "https://s3.amazonaws.com"
}

enum APIClientError: Error {
    case sessionError
    case statusCodeError
    case malformedResponseError
}

protocol APIClientProtocol {
    func get(endpoint: String, completionHandler: @escaping (Result<Any, APIClientError>) -> Void)
}

class APIClient: APIClientProtocol {
    // MARK: -
    
    let baseURL: URL
    let urlSession: URLSessionProtocol
    
    // MARK: - Init method
    
    init(urlSession: URLSessionProtocol = URLSession(configuration: .default)) {
        self.baseURL = URL(string: APIClientConstants.baseURLString)!
        self.urlSession = urlSession
    }
    
    init(baseURL: URL, urlSession: URLSessionProtocol = URLSession(configuration: .default)) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    // MARK: - Public methods
    
    func get(endpoint: String, completionHandler: @escaping (Result<Any, APIClientError>) -> Void) {
        let fullPathURL = buildPathURL(endpoint: endpoint)
                        
        buildAndExecuteDataTask(url: fullPathURL, completionHandler: completionHandler)
    }
    
    // MARK: - Private methods
    
    private func buildPathURL(endpoint: String) -> URL {
        return baseURL.appendingPathComponent(endpoint)
    }
    
    private func buildAndExecuteDataTask(url: URL, completionHandler: @escaping (Result<Any, APIClientError>) -> Void) {
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.sessionError))
                
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.sessionError))
                
                return
            }
            
            guard error == nil else {
                completionHandler(.failure(.sessionError))
                
                return
            }
            
            guard response.statusCode == 200 else {
                completionHandler(.failure(.statusCodeError))

                return
            }
            
            guard let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) else {
                completionHandler(.failure(.malformedResponseError))

                return
            }

            completionHandler(.success(jsonResponse))
        }
        
        dataTask.resume()
    }
}
