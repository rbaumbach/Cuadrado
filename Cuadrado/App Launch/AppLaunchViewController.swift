import UIKit

class AppLaunchViewController: UIViewController {
    // MARK: - Public properties

    var employeeNetworkService: EmployeeNetworkServiceProtocol = EmployeeNetworkService()
    var storyboardLoader: StoryboardLoaderProtocol = StoryboardLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeNetworkService.getEmployees { [weak self] result in
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
