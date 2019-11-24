import UIKit

class CuadradoViewController: UIViewController, UITableViewDataSource {
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var basicStatusLabel: UILabel!
    
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
            handleSuccess(employees: employees)
                        
        case .failure(_):
            handleFailure()
            
        case .none:
            preconditionFailure("CuadradoViewController has no employeesResult")
        }
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.tableFooterView = UIView()
    }
    
    private func handleSuccess(employees: [Employee]) {
        if employees.isEmpty {
            basicStatusLabel.text = "There are no employees"
            
            return
        }
        
        dataSource = employees
    }
    
    private func handleFailure() {
        basicStatusLabel.isHidden = false
    }
}
