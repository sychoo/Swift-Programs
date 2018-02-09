//
//  UserInfo.swift
//  LoginPage
//
//  Created by Administrator on 22/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit
import Firebase

var phoneNumber: String?

class UserInfoUpdate: UIViewController {

    // document reference for firebase
    var docRef: DocumentReference!
    
    // labels for regular info update windows
    @IBOutlet weak var parameterLabel: UILabel!

    // textfield for regular info update windows
    @IBOutlet weak var textField: UITextField!
    
/*
     // present alert at the beginning
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
     
        // Save Confirmation Alert
        // prompt user to continue
        // present the confirmation alert when password, email and phone numbers are parameters
        let saveAlert = UIAlertController(title: "Confirm", message: "Please ensure the accuracy of your information, You will be asked to verify the information that you provided.", preferredStyle: .alert)
        
        saveAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(saveAlert, animated: true, completion: nil)
    }
 */

    @IBAction func saveTapped(_ sender: Any)
    {
        if ((parameter == "Password") || (parameter == "Email") || (parameter == "Phone Number"))
        {
            let saveAlert = UIAlertController(title: "Confirm", message: "Please ensure the accuracy of your information, You will be asked to verify the information that you provided.", preferredStyle: .alert)
        
            saveAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            //self.presentAlert(alertContent: saveAlert)
            self.present(saveAlert, animated: true, completion: nil)
        
            saveAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler:{ (action) in self.saveInfo()
           /*
                // save verification email after saving data
                if parameter == "Email"
                {
                    self.sendVerificationEmail()
                }
 */
         }))// For Alert
        }
        else
        {
          self.saveInfo()
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Display only an arrow in the next ViewController navigation bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)


        parameterLabel.text = "New \(parameter!)"
        
        // Secure Text Entry For Password Modification
        if parameter == "Password"
        {
            textField.isSecureTextEntry = true
        }
        
        // Non-Secured Text Entry For other information
        else
        {
            textField.isSecureTextEntry = false
            textField.placeholder = "Please Enter Your Updated \(parameter!)"
        }
        
    }
    

    func saveToDatabase()
    {
        let user = Auth.auth().currentUser
        
        if let user = user
        {
            let uid = user.uid
            self.docRef = Firestore.firestore().document("Users/\(uid)/UserInfo/Profile")
            self.docRef.setData(["\(parameter!)": self.textField?.text! ?? ""], options: SetOptions.merge()) {(error: Error?) in
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
    } // function saveToDatabase() ends
    
    // cannot display sendVerificationEmail() Window hiercy
    // send verification email function
    func sendVerificationEmail()
    {
        print("I'm Here, Again") //test
        Auth.auth().currentUser?.sendEmailVerification(completion:
            { (Error) in
                if Error != nil
                {
                    let emailNotSentAlert = UIAlertController(title: "Email Verification Error", message: "Verification Email Failed to Send: \(Error!.localizedDescription)", preferredStyle: .alert)
                    
                    emailNotSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(emailNotSentAlert, animated: true, completion: nil)
                }
                    
                else
                {
                    let emailSentAlert = UIAlertController(title: "Email Verification", message: "Verification Email has been sent. Please check your Email and click the link to verify your account.", preferredStyle: .alert)
                    //emailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(emailSentAlert, animated: true, completion: nil)
                    emailSentAlert.addAction(UIAlertAction(title: "Close", style: .default, handler:{ action in
                        // dismiss window after email reset
                        self.dismiss(animated: true, completion: nil)}))
                }
        })
    } // function sendEmailVerification() Ends
    
    func sendVerificationCode()
    {
        print("Started Executing the function") //test
        PhoneAuthProvider.provider().verifyPhoneNumber(textField.text!, uiDelegate: nil, completion: {
            (verificationID, Error) in
            if Error != nil
            {
                print("\(Error!.localizedDescription)")
            }
                
            else
            {
                // Success
                print("Phone successfully verified!")
                let defaults = UserDefaults.standard
                defaults.set(verificationID, forKey: "authVerificationID")
                self.performSegue(withIdentifier: "phoneVerification", sender: self)
            }
        })
        print("Finished Sending Code, jumping to the segue") //test
    }
    
    // Save the Information to Firebase Authentication System
    func saveInfo()
    {
        // if the user did not type in anything, leave the field as what is was.
        // if the user did type, update their information

        // saveInfo() -> saveToDatabase()
        // Save Information to Firebase Database if Successfully Saved to Firebase Authentication System
        
        if ((self.textField?.text != "") && (parameter != "Password"))
        {
            if parameter == "Email"
            {
                // Verify new Email address, Update UserProfile (database), Warning : Cannot Login if Email Not Verified,Please Provide the accurate information. & VERIFY
                // Additional Action other than updating database
                if let user = Auth.auth().currentUser
                {
                    user.updateEmail(to: self.textField.text!, completion: { (Error) in
                        if Error != nil
                        {
                            // print error message
                            
                            print("\(Error!.localizedDescription)")
                            
                            // cannot display the alert. Alert is not in the window hiercy
                            let emailChangeAlert = UIAlertController(title: "Email Changing Error", message: "\(Error!.localizedDescription ) Please try again.", preferredStyle: .alert)
                            emailChangeAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(emailChangeAlert, animated: true, completion: nil)
                        }
                            
                        else
                        {
                            // successfully updated
                            print("Success")
                            self.saveToDatabase()
                            self.sendVerificationEmail()
                            //dismiss the VC after entering
                            //self.dismiss(animated: true, completion: nil)
                        }
                        
                    })
                }
            }
                
            else if parameter == "Phone Number"
            {
                // Phone Number Update. Verify Phone Number ASAP, Enter 6-digit verification code. Update User Profile (Database)
                // Additional Action other than updating database
                
                phoneNumber = textField.text!
                self.saveToDatabase()
                
                // Verify the phone Number
                // keep one of the following statements
                // self.sendVerificationCode()
                self.dismiss(animated: true, completion: nil)

                
            }
       
            // dismiss after save to database after any parameter else
            else
            {
                saveToDatabase()
                self.dismiss(animated: true, completion: nil)
            }
 
 
        } // if text field is not empty and not equal to password
            
        else if parameter == "Password"
        {
            // Retype Password & Change Password & Sign Out & Go to the main Segue (Exit)
            // Define Save Button Function
            if let user = Auth.auth().currentUser
            {
                user.updatePassword(to: self.textField.text!, completion: { (Error) in
                    if Error != nil
                    {
                        // print error message
                        print("\(Error!.localizedDescription)")
                        
                        // cannot display the alert. Alert is not in the window hiercy
                        let passwordChangeAlert = UIAlertController(title: "Password Changing Error", message: "\(Error!.localizedDescription ) Please try again.", preferredStyle: .alert)
                        passwordChangeAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        //self.presentAlert(alertContent: passwordChangeAlert)
                        self.present(passwordChangeAlert, animated: true, completion: nil)
                    }
                    
                        
                    else
                    {
                        // successfully updated
                        // Notice: Password Cannot Be Saved To Database!
                        print("Success")
                        
                        //dismiss the VC after entering
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                })
            }
        }
        // disable to save button if nothing was entered
        else
        {

        }
        // dismiss the VC after entering
        //self.dismiss(animated: true, completion: nil)
            /*
        else
        {
            self.dismiss(animated: true, completion: nil)
        }
 */
    }
/*
    func presentAlert(alertContent: UIAlertController!)
    {
        self.present(alertContent, animated: true, completion: nil)
    }
*/
  
    
}



