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
    var parameter = cellKey[myIndex]
    
    // textfield for reauth window
    @IBOutlet weak var reauthPassword: UITextField?
    
    
    // labels for regular info update windows
    @IBOutlet weak var parameterLabel: UILabel!

    // textfield for regular info update windows
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func continueTapped(_ sender: Any)
    {
        // get email address from user
        let user = Auth.auth().currentUser
        var email: String!
        if let user = user
        {
            email = user.email
        }
        
        var credential: AuthCredential // credential string
        let password = reauthPassword?.text // get password string
        
        //prompt user to re-enter info
        credential = EmailAuthProvider.credential(withEmail: email!, password: password!)
        
        user?.reauthenticate(with: credential, completion: { (error) in
            if error != nil
            {
                let reauthAlert = UIAlertController(title: "Error Reauthenticating User", message: "\(error?.localizedDescription ?? "Error Occurred when reauthenticating user") Please try again.", preferredStyle: .alert)
                
                //reauthAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                reauthAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(reauthAlert, animated: true, completion: nil)
            }
            else
            {
                //user reauthenticated successfully
                // Update Password Segue
                if self.parameter == "Password"
                {
                    self.performSegue(withIdentifier: "passwordUpdateSegue", sender: self)
                }
                    
                    // Update Email Segue
                else if self.parameter == "Email"
                {
                    self.performSegue(withIdentifier: "emailUpdateSegue", sender: self)
                }
                    
                    // Update Phone Number Segue
                else if self.parameter == "Phone Number"
                {
                    self.performSegue(withIdentifier: "phoneNumberUpdateSegue", sender: self)
                }
                    
                else
                {
                    print("Error!")
                }
            }
        })

    }
    
    @IBAction func saveTapped(_ sender: Any)
    {
        // if the user did not type in anything, leave the field as what is was.
        // if the user did type, update their information
        
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
        // Display only an arrow in the next ViewController navigation bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        if (parameter != "Password") && (parameter != "Email") &&        (parameter != "Phone Number")
        {
            parameterLabel.text = parameter
            textField.placeholder = "Please Enter Your Updated \(cellKey[myIndex])"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // Dismiss the keyboard when the view is tapped on
        reauthPassword?.resignFirstResponder()
    }

}



