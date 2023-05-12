//
//  RegistrationVC.swift
//  TestLogin
//
//  Created by Nikunj Donda on 12/05/23.
//

import UIKit

class RegistrationVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tblRole: UITableView!
    
    @IBOutlet weak var txtRole: UITextField!
    
    let arrRoles: [String] = ["Person with a Disability", "Community Member", "Disabilty Advocate", "Carer", "Support Worker", "Support Coordinator", "Business Representative"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tblRole.delegate = self
        self.tblRole.dataSource = self
        self.tblRole.isHidden = true
        self.tblRole.layer.borderColor = UIColor.lightGray.cgColor
        self.tblRole.layer.borderWidth = 1.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrRoles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let label = cell.viewWithTag(1) as? UILabel else {
            return cell
        }
        label.text = self.arrRoles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.txtRole.text = self.arrRoles[indexPath.row]
        self.tblRole.isHidden = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtRole {
            self.tblRole.isHidden = false
            return false
        } else {
            return true
        }
    }
}
