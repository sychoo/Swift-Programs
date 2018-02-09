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
    var profileRef: DocumentReference!
    var logRef: DocumentReference!
    //var docListener: ListenerRegistration!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var bioField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var birthdateField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    
    @IBAction func continueTapped(_ sender: Any)
    {
        if (firstNameField.text! == "") || (lastNameField.text! == "") || (birthdateField.text! == "")
        {
            let dataEntryError = UIAlertController(title: "Data Entry Error", message: "Required fields are not complete, please complete all the fields with * . ", preferredStyle: .alert)
            dataEntryError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dataEntryError, animated: true, completion: nil)
        }
        
        else
        {
            print("\(firstNameField)")
            let user = Auth.auth().currentUser
            // set isFirstTimeSignIn False after the user fill in the information
            if let user = user
            {
                let uid = user.uid
                logRef = Firestore.firestore().document("Users/\(uid)/UserInfo/Logs")
                logRef.setData(["isFirstTimeSignIn" : false])
                // set "isFirstTimeSignIn" to false after testing
            
                // if the information is not entered, keep the original information (do nothing)
                // if the information is entered, store it to the cloud
                profileRef = Firestore.firestore().document("Users/\(uid)/UserInfo/Profile")
                if firstNameField.text != ""
                {
                    profileRef.setData(["First Name": firstNameField.text!], options: SetOptions.merge())
                }
                if lastNameField.text != ""
                {
                    profileRef.setData(["Last Name": lastNameField.text!], options: SetOptions.merge())
                }
                if bioField.text != ""
                {
                    profileRef.setData(["Bio": bioField.text!], options: SetOptions.merge())
                }
                if countryField.text != ""
                {
                    profileRef.setData(["Country": countryField.text!], options: SetOptions.merge())
                }
                if stateField.text != ""
                {
                    profileRef.setData(["State/Province": stateField.text!], options: SetOptions.merge())
                }
                if birthdateField.text != ""
                {
                    profileRef.setData(["Birthdate": birthdateField.text!], options: SetOptions.merge())
                }
                if genderField.text != ""
                {
                    profileRef.setData(["Gender": genderField.text!], options: SetOptions.merge())
                }
            }
            performSegue(withIdentifier: "goToMainScreen", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        // Enhance Performance, remove unnecessary listener.
        //self.docListener.remove()
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
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // Dismiss the keyboard when the view is tapped on
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        bioField.resignFirstResponder()
        phoneNumberField.resignFirstResponder()
        countryField.resignFirstResponder()
        stateField.resignFirstResponder()
        birthdateField.resignFirstResponder()
        genderField.resignFirstResponder()
    }


}
