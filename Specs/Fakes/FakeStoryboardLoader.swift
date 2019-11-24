import UIKit
@testable import Cuadrado

class FakeStoryboardLoader: StoryboardLoaderProtocol {
    // MARK: - Captured properties
    
    var capturedLoadName: String?
    
    // MARK: - Stubbed properties
    
    var stubbedLoadViewController = UIViewController()
    
    // MARK: - <StoryboardLoaderProtocol>
    
    func load(name: String) -> UIViewController {
        capturedLoadName = name
        
        return stubbedLoadViewController
    }
}
