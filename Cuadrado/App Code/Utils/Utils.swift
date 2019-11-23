import Foundation

// MARK: - Dispatcher

protocol DispatcherProtocol {
    func mainAsync(completionHandler: @escaping () -> Void)
}

class Dispatcher: DispatcherProtocol {
    func mainAsync(completionHandler: @escaping () -> Void) {
        DispatchQueue.main.async(execute: completionHandler)
    }
}
