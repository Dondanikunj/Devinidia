import Foundation
import CoreData
import UIKit

class CoreData {
    
    static func saveUser(user : User) {
        let context = self.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "UserInfo", in: context)
        let newSet = NSManagedObject(entity: entity!, insertInto: context)
        newSet.setValue(user.dob, forKey: "dob")
        newSet.setValue(user.email, forKey: "email")
        newSet.setValue(user.firstName, forKey: "firstName")
        newSet.setValue(user.gender, forKey: "gender")
        newSet.setValue(user.id, forKey: "id")
        newSet.setValue(user.isFirstTime, forKey: "isFirstTime")
        newSet.setValue(user.lastName, forKey: "lastName")
        newSet.setValue(user.profilePic, forKey: "profilePic")
        newSet.setValue(user.roleName, forKey: "roleName")
        newSet.setValue(user.type, forKey: "type")
        newSet.setValue(user.userType, forKey: "userType")

        do {
            try context.save()
        } catch let error {
            print("error33",error.localizedDescription)
        }
    }
    
    static func getUsers() -> [User] {
        let context = self.getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
        request.returnsObjectsAsFaults = false
        var setListModels: [User] = []
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let email =  data.value(forKey: "email") as? String ?? ""
                let dict  = ["email": email] as [String : Any]
                if let obj =  User(dict: dict) {
                    setListModels.append(obj)
                }
                print(data)
            }
        } catch let error {
            print("error34",error.localizedDescription)
        }
        return setListModels
    }

    
    class func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}

