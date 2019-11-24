import Foundation
import UIKit

// MARK: - Dispatcher

protocol DispatcherProtocol {
    func mainAsync(completionHandler: @escaping () -> Void)
}

class Dispatcher: DispatcherProtocol {
    func mainAsync(completionHandler: @escaping () -> Void) {
        DispatchQueue.main.async(execute: completionHandler)
    }
}

// MARK: - StoryboardLoader

protocol StoryboardLoaderProtocol {
    func load(name: String) -> UIViewController
}

class StoryboardLoader: StoryboardLoaderProtocol {
    func load(name: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        
        return storyboard.instantiateInitialViewController()!
    }
}
