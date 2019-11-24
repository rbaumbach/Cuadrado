import UIKit

class CuadradoViewController: UIViewController, UITableViewDataSource {
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var employeesErrorLabel: UILabel!
    
    // MARK: - Public properties
        
    var employeesResult: Result<[Employee], APIClientError>!
    var dataSource: [Employee] = []
        
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
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
        setupDataSource()
        setupTableView()
    }
    
    private func setupDataSource() {
        switch employeesResult {
        case .success(let employees):
            dataSource = employees
            
        case .failure(_):
            employeesErrorLabel.isHidden = false
            
        case .none:
            preconditionFailure("CuadradoViewController has no employeesResult")
        }
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.tableFooterView = UIView()
    }
}
