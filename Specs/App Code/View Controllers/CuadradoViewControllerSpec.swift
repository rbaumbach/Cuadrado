import Quick
import Nimble
@testable import Cuadrado

class CuadradoViewControllerSpec: QuickSpec {
    override func spec() {
        describe("CuadradoViewController") {
            var subject: CuadradoViewController!
            
            var fakeDeserializer: FakeEmployeeDeserializer!
            var fakeEmployeesResult: Result<[Employee], APIClientError>!

            beforeEach {
                subject = loadStoryboard(name: "CuadradoViewController")
                
                // Easy access to some generated employees
                
                fakeDeserializer = FakeEmployeeDeserializer()
            }
            
            describe("when employees result fetch has successfully retrieved employee array") {
                beforeEach {
                    fakeEmployeesResult = .success(fakeDeserializer.stubbedEmployees)
                    
                    subject.employeesResult = fakeEmployeesResult
                    
                    _ = subject.view
                }
                
                it("loads up the data source") {
                    expect(subject.dataSource).to(equal(fakeDeserializer.stubbedEmployees))
                }
            }
            
            describe("when employees result fetch has failed") {
                beforeEach {
                    fakeEmployeesResult = .failure(.sessionError)
                    
                    subject.employeesResult = fakeEmployeesResult
                    
                    _ = subject.view
                }
                
                it("displays an error message") {
                    expect(subject.employeesErrorLabel.isHidden).to(beFalsy())
                }
            }
            
            describe("<UITableViewDataSource>") {
                beforeEach {
                    fakeEmployeesResult = .success(fakeDeserializer.stubbedEmployees)
                    
                    subject.employeesResult = fakeEmployeesResult
                    
                    _ = subject.view
                }
                
                describe("#numberOfSections(in:)") {
                    var numberOfSections: Int!
                    
                    beforeEach {
                        numberOfSections = subject.numberOfSections(in: subject.tableView)
                    }
                    
                    it("is always 1") {
                        expect(numberOfSections).to(equal(1))
                    }
                }
                
                describe("#tableView(_:numberOfRowsInSection:)") {
                    var numberOfRows: Int!
                    
                    beforeEach {
                        numberOfRows = subject.tableView(subject.tableView, numberOfRowsInSection: 0)
                    }
                    
                    it("returns the same number of rows that are in the data source") {
                        expect(numberOfRows).to(equal(subject.dataSource.count))
                    }
                }
                                
                describe("#tableView(_:cellForRowAt:)") {
                    var tableViewCell: UITableViewCell!
                    
                    beforeEach {
                        subject.dataSource = fakeDeserializer.stubbedEmployees
                        
                        tableViewCell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                    }
                    
                    it("creates a table view cell that shows the employee name") {
                        expect(tableViewCell.textLabel?.text).to(equal("Billy Goat"))
                    }
                }
            }
        }
    }
}
