import Quick
import Nimble
@testable import Cuadrado

class CuadradoViewControllerSpec: QuickSpec {
    override func spec() {
        describe("CuadradoViewController") {
            var subject: CuadradoViewController!
            
            var fakeEmployeeNetworkService: FakeEmployeeNetworkService!
            
            // Easy access to some generated employees
            
            var fakeDeserializer: FakeEmployeeDeserializer!

            beforeEach {
                subject = loadStoryboard(name: "CuadradoViewController")
                
                fakeEmployeeNetworkService = FakeEmployeeNetworkService()
                
                subject.employeeNetworkService = fakeEmployeeNetworkService
                
                fakeDeserializer = FakeEmployeeDeserializer()
                
                _ = subject.view
            }
            
            it("has a spinner, spinning by default in in the view (and will hide when stopped)") {
                expect(subject.activityIndicatorView.isAnimating).to(beTruthy())
                expect(subject.activityIndicatorView.hidesWhenStopped).to(beTruthy())
            }
            
            it("has an empty employee data source") {
                expect(subject.dataSource).to(beEmpty())
            }
            
            describe("when the view will appear") {
                beforeEach {
                    subject.viewWillAppear(false)
                }
                
                it("attempts to retreive the employees") {
                    expect(fakeEmployeeNetworkService.capturedCompletionHandler).toNot(beNil())
                }
                
                describe("on employee retrieval succes") {
                    beforeEach {
                        fakeEmployeeNetworkService.capturedCompletionHandler?(.success(fakeDeserializer.stubbedEmployees))
                    }
                    
                    it("removes the activity indicator view") {
                        expect(subject.activityIndicatorView.isAnimating).to(beFalsy())
                        expect(subject.activityIndicatorView.isHidden).to(beTruthy())
                    }
                }
                
                describe("on employee retrieval failure") {
                    beforeEach {
                        fakeEmployeeNetworkService.capturedCompletionHandler?(.failure(.sessionError))
                    }
                    
                    it("removes the activity indicator view") {
                        expect(subject.activityIndicatorView.isAnimating).to(beFalsy())
                        expect(subject.activityIndicatorView.isHidden).to(beTruthy())
                    }
                }
            }
            
            describe("<UITableViewDataSource>") {
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
