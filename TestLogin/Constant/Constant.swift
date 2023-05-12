
import Foundation


//MARK: - App Constants
class Constant: NSObject {
    
    //MARK: - API Constants
    struct ServerAPI {
        struct URL {
            static let kBaseURL = "http://ariel.itcc.net.au/api/v1/auth/"
            static let kLogin = kBaseURL + "login"
            static let kGetProfile = kBaseURL + "get-profile"

        }
    }
}
