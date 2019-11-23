import Quick
import Nimble
@testable import Cuadrado

class CuadradoViewControllerSpec: QuickSpec {
    override func spec() {
        describe("CuadradoViewController") {
            var subject: CuadradoViewController!

            beforeEach {
                subject = loadStoryboard(name: "CuadradoViewController")
                
                _ = subject.view
            }
            
            it("exists") {
                expect(subject).toNot(beNil())
            }
            
            it("has a table view") {
                expect(subject.tableView).toNot(beNil())
            }
        }
    }
}
