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
                describe("when there are no employees") {
                    beforeEach {
                        fakeEmployeesResult = .success([])
                        
                        subject.employeesResult = fakeEmployeesResult
                        
                        _ = subject.view
                    }

                    it("it displays proper message") {
                        expect(subject.basicStatusLabel.text).to(equal("There are no employees"))
                    }
                    
                    it("it doesn't show separator lines because there is an empty footer view") {
                        expect(subject.tableView.tableFooterView).toNot(beNil())
                    }
                }
                
                describe("when there is at least one employee") {
                    beforeEach {
                        fakeEmployeesResult = .success(fakeDeserializer.stubbedEmployees)
                        
                        subject.employeesResult = fakeEmployeesResult
                        
                        _ = subject.view
                    }
                    
                    it("loads up the data source") {
                        expect(subject.dataSource).to(equal(fakeDeserializer.stubbedEmployees))
                    }
                }
            }
            
            describe("when employees result fetch has failed") {
                beforeEach {
                    fakeEmployeesResult = .failure(.sessionError)
                    
                    subject.employeesResult = fakeEmployeesResult
                    
                    _ = subject.view
                }
                
                it("displays proper error message") {
                    let expectedErrorMessage = "Error: Unable to fetch employees"
                    
                    expect(subject.basicStatusLabel.isHidden).to(beFalsy())
                    expect(subject.basicStatusLabel.text).to(equal(expectedErrorMessage))
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
