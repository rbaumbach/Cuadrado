import Foundation

protocol EmployeeDeserialzerProtocol {
    func deserialize(jsonResponse: Any) -> [Employee]
}

class EmployeeDeserialzer: EmployeeDeserialzerProtocol {
    // MARK: - Public methods
    
    func deserialize(jsonResponse: Any) -> [Employee] {
        guard let serializedJSONResponse = jsonResponse as? [String: Any] else {
            return []
        }
        
        guard let serializedEmployees = serializedJSONResponse["employees"] as? [[String: Any]] else {
            return []
        }
        
        let employees = serializedEmployees.map { serialedJSONEmployee -> Employee in
            let serializedEmployee = serialedJSONEmployee as! [String: String]
            
            let deserializedEmployee = deserializeEmployee(serializedEmployee: serializedEmployee)
            
            return deserializedEmployee
        }
        
        return employees
    }
    
    private func deserializeEmployee(serializedEmployee: [String: String]) -> Employee {
        // Required fields
        
        let id = serializedEmployee["uuid"]!
        let fullName = serializedEmployee["full_name"]!
        let emailAddress = serializedEmployee["email_address"]!
        let team = serializedEmployee["team"]!
        let typeString = serializedEmployee["employee_type"]!
        let employeeType = EmployeeType(rawValue: typeString)!
        
        // Optional fields
        
        let phoneNumber = serializedEmployee["phone_number"]
        let biography = serializedEmployee["biography"]
        
        var smallPhotoURL: URL?
        if let smallPhotoURLString = serializedEmployee["photo_url_small"] {
            smallPhotoURL = URL(string: smallPhotoURLString)
        }
        
        var largePhotoURL: URL?
        if let largePhotoURLString = serializedEmployee["photo_url_large"] {
            largePhotoURL = URL(string: largePhotoURLString)
        }
        
        let employee = Employee(id: id,
                                fullname: fullName,
                                phoneNumber: phoneNumber,
                                email: emailAddress,
                                biography: biography,
                                smallPhotoURL: smallPhotoURL,
                                largePhotoURL: largePhotoURL,
                                team: team,
                                type: employeeType)
        return employee
    }
}
