//
//  UserInfo.swift
//  LoginPage
//
//  Created by Administrator on 22/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit
import Firebase

class UserInfoUpdate: UIViewController {

    //let cellKey = ["First Name", "Last Name", "Email", "Phone Number", "Password", "Country", "State", "Birthdate"]
    //var cellValue = ["", "", "", "", "", "", "", ""]
    //var firstName, lastName, email, phoneNumber, password, country, state, DOB: String?
    //var cellValue = ["First Name", "Last Name", "Email", "Phone Number", "Password", "Country", "State", "Birthdate"]
    //let cellValue = fetchData()

    //var cellValue:Array<String> = []
    var docRef: DocumentReference!
    var parameter = cellKey[myIndex]
    @IBOutlet weak var parameterLabel: UILabel!

    @IBOutlet weak var textField: UITextField!
    
    @IBAction func saveTapped(_ sender: Any)
    {
        // if the user did not type in anything, leave the field as what is was.
        // if the user did type, update
        
    if textField?.text != ""
    {
        let user = Auth.auth().currentUser
        /*
        if parameter == "Password"
        {
            
        }
        else if parameter == "Phone Number"
        {
            
        }
        
        else if parameter == "Email"
        {
            
        }
 */
        if let user = user
        {
            let uid = user.uid
            docRef = Firestore.firestore().document("Users/\(uid)/UserInfo/Profile")
            //  db.document("Users/\(uid)/UserInfo/Profile").setData(["name": "Los Angeles", "state": "CA"])
            //db.collection("Users").document(uid).collection("UserInfo").document("Profile").setData(["name": "Los Angeles", "state": "CA"])
            docRef.setData(["\(parameter)": textField?.text! ?? ""], options: SetOptions.merge()) {(error: Error?) in
                if let error = error {
                    print("\(error.localizedDescription)")
                }
                else{
                    print("Data Saved!")
                }
            }

        }
        self.dismiss(animated: true, completion: nil)
        } // if statement
    else
    {
        self.dismiss(animated: true, completion: nil)
    }
    }
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update Password Segue
        if parameter == "Password"
        {
            
        }
        // Update Email Segue
        else if parameter == "Email"
        {
            
        }
        // Update Phone Number Segue
        else if parameter == "Phone Number"
        {
            
        }
        
        // Update Database Profiles
        else
        {
        parameterLabel.text = parameter
        textField.placeholder = "Please Enter Your Updated \(cellKey[myIndex])"
        }

    }


}
