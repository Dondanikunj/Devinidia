import Foundation

class User: NSObject {
    
    var dob: String
    var email: String
    var firstName: String
    var gender: String
    var id: Int
    var isFirstTime: Int
    var lastName: String
    var profilePic: String
    var roleName: String
    var type: String
    var userType: Int

    init?(dict: [String: Any]) {
        self.dob = dict["dob"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
        self.firstName = dict["first_name"] as? String ?? ""
        self.gender = dict["gender"] as? String ?? ""
        self.id = dict["id"] as? Int ?? 0
        self.isFirstTime = dict["is_first_time"] as? Int ?? 0
        self.lastName = dict["last_name"] as? String ?? ""
        self.profilePic = dict["profile_pic"] as? String ?? ""
        self.roleName = dict["role_name"] as? String ?? ""
        self.type = dict["type"] as? String ?? ""
        self.userType = dict["user_type"] as? Int ?? 0
    }
    
}
