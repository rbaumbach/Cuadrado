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
            
            let id = serializedEmployee["uuid"]!
            let fullName = serializedEmployee["full_name"]!
            let phoneNumber = serializedEmployee["phone_number"]!
            let emailAddress = serializedEmployee["email_address"]!
            let biography = serializedEmployee["biography"]!
            let smallPhotoURLString = serializedEmployee["photo_url_small"]!
            let largePhotoURLString = serializedEmployee["photo_url_large"]!
            let team = serializedEmployee["team"]!
            let typeString = serializedEmployee["employee_type"]!
            
            let smallPhotoURL = URL(string: smallPhotoURLString)!
            let largePhotoURL = URL(string: largePhotoURLString)!
            
            let employeePhoto = EmployeePhoto(smallURL: smallPhotoURL, largeURL: largePhotoURL)
            let employeeType = EmployeeType(rawValue: typeString)!
            
            let employee = Employee(id: id, fullname: fullName, phoneNumber: phoneNumber, email: emailAddress,
                                    biography: biography, photo: employeePhoto, team: team, type: employeeType)
            
            return employee
        }
        
        return employees
    }
}
