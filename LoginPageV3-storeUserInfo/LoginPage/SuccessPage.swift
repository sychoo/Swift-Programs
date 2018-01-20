//
//  successPage.swift
//  LoginPage
//
//  Created by Administrator on 20/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SuccessPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func signOutTapped(_ sender: Any)
    {
        // if there is a user signed in
        if Auth.auth().currentUser != nil
        {
            do
            {
                try Auth.auth().signOut()
                if Auth.auth().currentUser == nil
                {
                    // go to main Page
                    //self.performSegue(withIdentifier: "signInPage", sender: self)
                    //self.dismiss(animated: true, completion: nil)
                    navigationController?.popViewController(animated: true)
                }
                
            }
            catch let signOutError as NSError
            {
                // Error Handling (Alert)
                let signOutErrorAlert = UIAlertController(title: "Sign-out Error", message: "\(signOutError) Please Try Again.", preferredStyle: .alert)
                signOutErrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(signOutErrorAlert, animated: true, completion: nil)
            }
            catch
            {
                let unknownErrorAlert = UIAlertController(title: "Unknown Error", message: "Please Try Again.", preferredStyle: .alert)
                unknownErrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(unknownErrorAlert, animated: true, completion: nil)
            }
        }
    }
}
