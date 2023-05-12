//
//  UserDetailsVC.swift
//  TestLogin
//
//  Created by Nikunj Donda on 12/05/23.
//

import UIKit

class UserDetailsVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblDob: UILabel!

    @IBOutlet weak var imgProfile: UIImageView!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let coreDataUser = CoreData.getUsers()
        if let user = self.user {
            self.lblName.text = user.firstName + " " + user.lastName
            self.lblEmail.text = user.email
            self.lblRole.text = user.roleName
            self.lblDob.text = user.dob
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
