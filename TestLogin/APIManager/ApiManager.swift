import UIKit
import Foundation
import SystemConfiguration

enum HTTPMethod: String {
    case POST = "POST"
    case GET = "GET"
}


class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
    // MARK: - Check for internet connection
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }

    // MARK: - API Call
    class func apiCall(_ urlString: String, header: String, data: [String: Any]?, method: HTTPMethod, callback: ((_ success: Bool, _ data: Any?, _ error: Error?) -> Void)?) {
        
        if(isConnectedToNetwork())  {
            guard let serviceUrl = URL(string: urlString) else { return }
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = method.rawValue
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            if header != "" {
                request.setValue( "Bearer \(header)", forHTTPHeaderField: "Authorization")
            }
            if let params = data {
                guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                    return
                }
                request.httpBody = httpBody
            }
            request.timeoutInterval = 60
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        callback?(true, json, nil)
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }else{
            print("internet")
            print("Check your network connection.")
        }
    }
}

