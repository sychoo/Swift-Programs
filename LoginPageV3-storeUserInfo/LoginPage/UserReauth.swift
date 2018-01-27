//
//  UserReauth.swift
//  LoginPage
//
//  Created by Administrator on 27/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit
import Firebase

class UserReauth: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var reauthPassword: UITextField!
    
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
                // user reauthenticated successfully
                // go to updateSegue
                //self.parameterLabel.text = "password"
                if parameter == "Delete Account"
                {
                    self.performSegue(withIdentifier: "deleteAccountSegue", sender: self)                    
                }
                
                else
                {
                    self.performSegue(withIdentifier: "goToUpdateSegue", sender: self)
                }
            }
        })
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // Dismiss the keyboard when the view is tapped on
        reauthPassword?.resignFirstResponder()
    }

}
