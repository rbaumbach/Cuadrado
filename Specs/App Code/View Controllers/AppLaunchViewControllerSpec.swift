import Quick
import Nimble
@testable import Cuadrado

class AppLaunchViewControllerSpec: QuickSpec {
    override func spec() {
        describe("AppLaunchViewController") {
            var subject: AppLaunchViewController!
            
            var fakeEmployeeNetworkService: FakeEmployeeNetworkService!
            var fakeStoryboardLoader: FakeStoryboardLoader!
            var fakeDeserializer: FakeEmployeeDeserializer!

            beforeEach {
                subject = loadStoryboard(name: "AppLaunchViewController")
                
                fakeEmployeeNetworkService = FakeEmployeeNetworkService()
                fakeStoryboardLoader = FakeStoryboardLoader()
                
                subject.employeeNetworkService = fakeEmployeeNetworkService
                subject.storyboardLoader = fakeStoryboardLoader
                
                // Easy employees...
                
                fakeDeserializer = FakeEmployeeDeserializer()
                
                _ = subject.view
            }
            
            describe("retrieving the employees") {
                var result: Result<[Employee], APIClientError>!
                var cuadradoViewController: CuadradoViewController!
                
                beforeEach {
                    cuadradoViewController = (StoryboardLoader().load(name: "CuadradoViewController") as! CuadradoViewController)
                    fakeStoryboardLoader.stubbedLoadViewController = cuadradoViewController
                    
                    result = .success(fakeDeserializer.stubbedEmployees)
                    
                    fakeEmployeeNetworkService.capturedCompletionHandler?(result)
                }
                
                it("loads and presents the cuadrado view controller with the given employees result fullscreen") {
                    expect(fakeStoryboardLoader.capturedLoadName).to(equal("CuadradoViewController"))
                    expect(cuadradoViewController.modalPresentationStyle).to(equal(.fullScreen))
                    expect(cuadradoViewController.employeesResult).to(equal(result))
                }
            }
        }
    }
}
