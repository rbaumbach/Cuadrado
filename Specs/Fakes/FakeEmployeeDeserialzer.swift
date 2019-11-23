import Foundation
@testable import Cuadrado

class FakeEmployeeDeserializer: EmployeeDeserialzerProtocol {
    // MARK: - Captured properties
    
    var capturedDeserializerJSONResponse: Any?
    
    // MARK: - Stubbed properties
    
    var stubbedEmployees: [Employee] = {
        let employeePhoto1 = EmployeePhoto()
        let employeeType1 = EmployeeType.fullTime
        
        let employee1 = Employee(id: "123", fullname: "Billy", phoneNumber: "333-333-3333", email: "billy@goat.com", biography: "Just an ordinary billy goat",
                                 photo: employeePhoto1, team: "horns", type: employeeType1)
        
        let employeePhoto2 = EmployeePhoto()
        let employeeType2 = EmployeeType.contractor
        
        let employee2 = Employee(id: "456", fullname: "Ram", phoneNumber: "444-444-4444", email: "ram@goat.com", biography: "A goat with rams",
                                 photo: employeePhoto2, team: "horns", type: employeeType2)
        
        return [employee1, employee2]
    }()
    
    // MARK: - <EmployeeNetworkServiceProtocol>
    
    func deserialize(jsonResponse: Any) -> [Employee] {
        capturedDeserializerJSONResponse = jsonResponse
        
        return stubbedEmployees
    }
}
