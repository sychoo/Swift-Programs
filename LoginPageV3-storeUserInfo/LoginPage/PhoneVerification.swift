//
//  PhoneVerification.swift
//  LoginPage
//
//  Created by Administrator on 28/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit
import Firebase

class PhoneVerification: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBAction func verifyTapped(_ sender: Any)
    {
        if let user = Auth.auth().currentUser
        {
            let defaults = UserDefaults.standard
            let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVerificationID")!, verificationCode: textField.text!)
            user.updatePhoneNumber(credential, completion: { (Error) in
                if Error != nil
                {
                    // print error message
                    print("Failed Phone Update")
                }
                    
                else
                {
                    // successfully updated
                    print("Success Phone Update")
                    self.label.text = "Successful Phone Update"
                    
                }
                
            })
        }
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

}
