import UIKit

class AppLaunchViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Public properties

    var sdWebImageWrapper: SDWebImageWrapperProtocol = SDWebImageWrapper()
    var employeeNetworkService: EmployeeNetworkServiceProtocol = EmployeeNetworkService()
    var storyboardLoader: StoryboardLoaderProtocol = StoryboardLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showActivityIndicator()
        
        sdWebImageWrapper.neverExpireImageCache()
        
        employeeNetworkService.getEmployees { [weak self] result in
            self?.activityIndicatorView.stopAnimating()
            
            self?.presentCuadradoVieController(result: result)
        }
    }
        
    // MARK: - Private methods
    
    private func showActivityIndicator() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    private func presentCuadradoVieController(result: Result<[Employee], APIClientError>) {
        let cuadradoViewController = storyboardLoader.load(name: "CuadradoViewController") as! CuadradoViewController
        
        cuadradoViewController.modalPresentationStyle = .fullScreen
        cuadradoViewController.employeesResult = result

        present(cuadradoViewController, animated: false)
    }
}
