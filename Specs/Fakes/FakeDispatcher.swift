import Foundation
@testable import Cuadrado

class FakeDispatcher: DispatcherProtocol {
    // MARK: - Captured properties
    
    var capturedMainAsyncCompletionHandler: (() -> Void)?
    
    // MARK: - <DispatcherProtocol>
    
    func mainAsync(completionHandler: @escaping () -> Void) {
        capturedMainAsyncCompletionHandler = completionHandler
    }
}
