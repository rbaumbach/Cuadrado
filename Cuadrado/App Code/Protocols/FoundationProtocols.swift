import Foundation

// MARK: - URLSession

protocol URLSessionProtocol {
    init(configuration: URLSessionConfiguration)

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }
