import Quick
import Nimble
@testable import Cuadrado

class EmployeeNetworkServiceSpec: QuickSpec {
    override func spec() {
        describe("EmployeeNetworkService") {
            var subject: EmployeeNetworkService!

            beforeEach {
                subject = EmployeeNetworkService()
            }
            
            it("exists") {
                expect(subject).toNot(beNil())
            }
        }
    }
}
