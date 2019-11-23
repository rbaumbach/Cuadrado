import Quick
import Nimble
@testable import Cuadrado

class EmployeeDeserialzerSpec: QuickSpec {
    override func spec() {
        describe("EmployeeDeserialzer") {
            var subject: EmployeeDeserialzer!

            beforeEach {
                subject = EmployeeDeserialzer()
            }
            
            describe("#deserialize(jsonResonse:)") {
                var employees: [Employee]!
                var jsonResponse: Any!
                
                beforeEach {
                    jsonResponse = [ "employees" : [ [ "uuid" : "0d8fcc12-4d0c-425c-8355-390b312b909c",
                                                       "full_name" : "Justine Mason",
                                                       "phone_number" : "5553280123",
                                                       "email_address" : "jmason.demo@squareup.com",
                                                       "biography" : "Engineer on the Point of Sale team.",
                                                       "photo_url_small" : "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
                                                       "photo_url_large" : "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg",
                                                       "team" : "Point of Sale",
                                                       "employee_type" : "FULL_TIME" ],
                                                     
                                                     [  "uuid" : "a98f8a2e-c975-4ba3-8b35-01f719e7de2d",
                                                        "full_name" : "Camille Rogers",
                                                        "phone_number" : "5558531970",
                                                        "email_address" : "crogers.demo@squareup.com",
                                                        "biography" : "Designer on the web marketing team.",
                                                        "photo_url_small" : "https://s3.amazonaws.com/sq-mobile-interview/photos/5095a907-abc9-4734-8d1e-0eeb2506bfa8/small.jpg",
                                                        "photo_url_large" : "https://s3.amazonaws.com/sq-mobile-interview/photos/5095a907-abc9-4734-8d1e-0eeb2506bfa8/large.jpg",
                                                        "team" : "Public Web & Marketing",
                                                        "employee_type" : "PART_TIME" ] ] ]
                    
                    employees = subject.deserialize(jsonResponse: jsonResponse as Any)
                }
                
                it("deserializes the jsonResponse properley") {
                    let expectedEmployeePhoto1 = EmployeePhoto(smallURL: URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg")!,
                                                               largeURL: URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg")!)
                    
                    let expectedEmployeeType1 = EmployeeType(rawValue: "FULL_TIME")!
                    
                    let expectedEmployee1 = Employee(id: "0d8fcc12-4d0c-425c-8355-390b312b909c", fullname: "Justine Mason", phoneNumber: "5553280123", email: "jmason.demo@squareup.com",
                                                     biography: "Engineer on the Point of Sale team.", photo: expectedEmployeePhoto1, team: "Point of Sale", type: expectedEmployeeType1)
                    
                    let expectedEmployeePhoto2 = EmployeePhoto(smallURL: URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/5095a907-abc9-4734-8d1e-0eeb2506bfa8/small.jpg")!,
                                                               largeURL: URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/5095a907-abc9-4734-8d1e-0eeb2506bfa8/large.jpg")!)
                    
                    let expectedEmployeeType2 = EmployeeType(rawValue: "PART_TIME")!
                    
                    let expectedEmployee2 = Employee(id: "a98f8a2e-c975-4ba3-8b35-01f719e7de2d", fullname: "Camille Rogers", phoneNumber: "5558531970", email: "crogers.demo@squareup.com",
                                                     biography: "Designer on the web marketing team.", photo: expectedEmployeePhoto2, team: "Public Web & Marketing", type: expectedEmployeeType2)
                    
                    expect(employees).to(equal([expectedEmployee1, expectedEmployee2]))
                }
            }
        }
    }
}
