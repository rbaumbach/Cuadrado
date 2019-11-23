import Quick
import Nimble
@testable import Cuadrado

class EmployeeNetworkServiceSpec: QuickSpec {
    override func spec() {
        describe("EmployeeNetworkService") {
            var subject: EmployeeNetworkService!
            
            var fakeAPIClient: FakeAPIClient!
            
            beforeEach {
                fakeAPIClient = FakeAPIClient()

                subject = EmployeeNetworkService(apiClient: fakeAPIClient)
            }
            
            it("exists") {
                expect(subject).toNot(beNil())
            }
        }
    }
}
