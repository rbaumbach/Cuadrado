import UIKit

class AppLaunchViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Public properties

    var employeeNetworkService: EmployeeNetworkServiceProtocol = EmployeeNetworkService()
    var storyboardLoader: StoryboardLoaderProtocol = StoryboardLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        
        employeeNetworkService.getEmployees { [weak self] result in
            self?.activityIndicatorView.stopAnimating()
            
            self?.presentCuadradoVieController(result: result)
        }
    }
        
    // MARK: - Private methods
    
    private func presentCuadradoVieController(result: Result<[Employee], APIClientError>) {
        let cuadradoViewController = storyboardLoader.load(name: "CuadradoViewController") as! CuadradoViewController
        
        cuadradoViewController.modalPresentationStyle = .fullScreen
        cuadradoViewController.employeesResult = result

        present(cuadradoViewController, animated: false)
    }
}
