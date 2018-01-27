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
    
    // parameter that is passed from last segue
    //var parameter = cellKey[myIndex]
    
    // textfield for reauth window

    
    
    // labels for regular info update windows
    @IBOutlet weak var parameterLabel: UILabel!

    // textfield for regular info update windows
    @IBOutlet weak var textField: UITextField!
    

    
    @IBAction func saveTapped(_ sender: Any)
    {
        // if the user did not type in anything, leave the field as what is was.
        // if the user did type, update their information
        
        if ((textField?.text != "") && (parameter != "Password"))
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
                    docRef.setData(["\(parameter!)": textField?.text! ?? ""], options: SetOptions.merge()) {(error: Error?) in
                        if let error = error
                        {
                            print("\(error.localizedDescription)")
                        }
                        else
                        {
                            print("Data Saved!")
                        }
                    }

            }
            
            if parameter == "Email"
            {
                // Verify new Email address, Update UserProfile (database), Warning : Cannot Login if Email Not Verified,Please Provide the accurate information. & VERIFY
                // Additional Action other than updating database
                if let user = Auth.auth().currentUser
                {
                    user.updateEmail(to: textField.text!, completion: { (Error) in
                    if Error != nil
                    {
                        // print error message
                        print("\(Error?.localizedDescription ?? "Error")")
                    }
                    
                    else
                    {
                        // successfully updated
                        print("Success")
                    }
                        
                    })
                }
            }
                
            else if parameter == "Phone Number"
            {
                // Phone Number Update. Verify Phone Number ASAP, Enter 6-digit verification code. Update User Profile (Database)
                // Additional Action other than updating database
                if let user = Auth.auth().currentUser
                {
                    /*user.updatePhoneNumber(<#T##phoneNumberCredential: PhoneAuthCredential##PhoneAuthCredential#>, completion: { (Error) in
                        if Error != nil
                        {
                            // print error message
                        }
                            
                        else
                        {
                            // successfully updated
                        }
                        
                    })*/
                }
 
            }
            
            else
            {
                self.dismiss(animated: true, completion: nil)
            }
        } // if text field is not empty
            
        else if parameter == "Password"
        {
            // Retype Password & Change Password & Sign Out & Go to the main Segue (Exit)
            // Define Save Button Function
            if let user = Auth.auth().currentUser
            {
                user.updatePassword(to: textField.text!, completion: { (Error) in
                    if Error != nil
                    {
                        // print error message
                    }
                        
                    else
                    {
                        // successfully updated
                    }
                    
                })
            }
        }
            
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
        // Display only an arrow in the next ViewController navigation bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)


        parameterLabel.text = parameter
        textField.placeholder = "Please Enter Your Updated \(parameter!)"
        
    }
    


}



