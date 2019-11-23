import UIKit

func loadStoryboard<T: UIViewController>(name: String) -> T {
    let storyboard = UIStoryboard(name: name, bundle: nil)
    
    guard let viewController = storyboard.instantiateInitialViewController() as? T else {
        preconditionFailure("Cannot load view controller from storyboard!")
    }
    
    return viewController
}
