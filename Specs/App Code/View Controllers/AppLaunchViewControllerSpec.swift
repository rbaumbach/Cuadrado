import Quick
import Nimble
@testable import Cuadrado

class AppLaunchViewControllerSpec: QuickSpec {
    override func spec() {
        describe("AppLaunchViewController") {
            var subject: AppLaunchViewController!
            
            var fakeSDWebImageWrapper: FakeSDWebImageWrapper!
            var fakeEmployeeNetworkService: FakeEmployeeNetworkService!
            var fakeStoryboardLoader: FakeStoryboardLoader!
            var fakeDeserializer: FakeEmployeeDeserializer!

            beforeEach {
                subject = loadStoryboard(name: "AppLaunchViewController")
                
                fakeSDWebImageWrapper = FakeSDWebImageWrapper()
                fakeEmployeeNetworkService = FakeEmployeeNetworkService()
                fakeStoryboardLoader = FakeStoryboardLoader()
                
                subject.sdWebImageWrapper = fakeSDWebImageWrapper
                subject.employeeNetworkService = fakeEmployeeNetworkService
                subject.storyboardLoader = fakeStoryboardLoader
                
                // Easy employees...
                
                fakeDeserializer = FakeEmployeeDeserializer()
                
                _ = subject.view
            }
            
            it("shows the activity indicator view") {
                expect(subject.activityIndicatorView.isHidden).to(beFalsy())
                expect(subject.activityIndicatorView.isAnimating).to(beTruthy())
            }
            
            it("makes sure that SDWebImage never expires the image cache (by default it's 1 week)") {
                expect(fakeSDWebImageWrapper.didCallNeverExpireImageCache).to(beTruthy())
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
                
                it("stops animating the activity indicator") {
                    expect(subject.activityIndicatorView.isHidden).to(beTruthy())
                    expect(subject.activityIndicatorView.isAnimating).to(beFalsy())
                }
            }
        }
    }
}
