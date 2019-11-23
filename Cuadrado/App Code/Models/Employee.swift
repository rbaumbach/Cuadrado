import Foundation

enum EmployeeType: Equatable {
    case fullTime
    case partTime
    case contractor
}

struct EmployeePhoto: Equatable {
    // MARK: - Readonly properties
    
    let smallURL: URL?
    let largeURL: URL?
    
    // MARK: - Init method
    
    init(smallURL: URL? = nil, largeURL: URL? = nil) {
        self.smallURL = smallURL
        self.largeURL = largeURL
    }
}

struct Employee: Equatable {
    // MARK: - Readonly public properties
    
    let id: String
    let fullname: String
    let phoneNumber: String?
    let email: String
    let biography: String?
    let photo: EmployeePhoto?
    let team: String
    let type: EmployeeType
    
    // MARK: - Init method
    
    init(id: String, fullname: String, phoneNumber: String? = nil, email: String, biography: String? = nil,
         photo: EmployeePhoto? = nil, team: String, type: EmployeeType) {
        self.id = id
        self.fullname = fullname
        self.phoneNumber = phoneNumber
        self.email = email
        self.biography = biography
        self.photo = photo
        self.team = team
        self.type = type
    }
}
