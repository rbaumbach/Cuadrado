import UIKit

class CuadradoViewController: UIViewController, UITableViewDataSource {
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Public properties
    
    var employeeNetworkService: EmployeeNetworkServiceProtocol = EmployeeNetworkService()
    
    var dataSource: [Employee] = []
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        employeeNetworkService.getEmployees { [weak self] result in
            guard let self = self else {
                return
            }
            
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    // MARK: - <UITableViewDataSource>
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = dataSource[indexPath.row].fullname
        
        return cell
    }
    
    // MARK: - Private methods
    
    private func setup() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
