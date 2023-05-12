//
//  ViewController.swift
//  TestLogin
//
//  Created by Nikunj Donda on 12/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var token: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.btnLogin.layer.cornerRadius = 5.0
    }

    func navigateToDetails(user: User) {
        DispatchQueue.main.async {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserDetailsVC") as? UserDetailsVC {
                vc.user = user
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func onTapLogin(_ sender: UIButton) {
        self.callLoginAPI()
    }
    
    @IBAction func onTapRegister(_ sender: UIButton) {
        DispatchQueue.main.async {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegistrationVC") as? RegistrationVC {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension ViewController {
    func callLoginAPI() {
        let email = self.txtEmail.text ?? "kate@gmail.com"
        let password = self.txtPassword.text ?? "12345678"
        let parameterDictionary: [String: Any] = ["email": email,
                                     "password": password,
                                     "platform": "iOS",
                                     "os_version": "iOS 14.3",
                                     "application_version": "V1",
                                     "model": "iPhone",
                                     "type": "Gmail",
                                     "uid": "xyz"]
        
        APIManager.apiCall(Constant.ServerAPI.URL.kLogin, header: "", data: parameterDictionary, method: .POST) { success, data, error in
            if let data = data {
                do {
                    let dict = data as? [String: Any] ?? [:]
                    self.token = dict["token"] as? String ?? ""
                    self.getProfile()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func getProfile() {
        
        APIManager.apiCall(Constant.ServerAPI.URL.kGetProfile, header: self.token, data: nil, method: .GET) { success, data, error in
            if let data = data {
                do {
                    let dict = data as? [String: Any] ?? [:]
                    let userDict = dict["item"] as? [String: Any] ?? [:]
                    if let user = User(dict: userDict) {
                        CoreData.saveUser(user: user)
                        self.navigateToDetails(user: user)
                    }
                    print(data)
                } catch {
                    print(error)
                }
            }
        }
    }
}
