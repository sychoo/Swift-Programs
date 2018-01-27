//
//  FirstTimeSignIn.swift
//  LoginPage
//
//  Created by Administrator on 25/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit
import Firebase

class FirstTimeSignIn: UIViewController {

    @IBAction func continueTapped(_ sender: Any)
    {
        let user = Auth.auth().currentUser
        // set isFirstTimeSignIn False after the user fill in the information
        if let user = user
        {
            let uid = user.uid
            Firestore.firestore().document("Users/\(uid)/UserInfo/Logs").setData(["isFirstTimeSignIn" : false])
        }
        performSegue(withIdentifier: "goToMainScreen", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // Dismiss the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
 */

}
