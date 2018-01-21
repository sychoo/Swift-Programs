//
//  ViewController.swift
//  LoginPage
//
//  Created by Administrator on 14/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseAuth

class SignInPage: UIViewController {
    
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    


    var isSignIn:Bool = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Display only an arrow in the next ViewController navigation bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    // password reset
    @IBAction func forgotPasswordTapped(_ sender: Any)
    {
        let forgotPasswordAlert = UIAlertController(title: "Forgot Password?", message: "Don't worry. We can reset it for you. Just enter your email address here.", preferredStyle: .alert)
        forgotPasswordAlert.addTextField
        {
                (textField) in textField.placeholder = "Enter you email address"
        }
        forgotPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
             self.present(forgotPasswordAlert, animated: true, completion: nil)
        forgotPasswordAlert.addAction(UIAlertAction(title: "Reset Password", style: .default, handler:{ (action) in
            let resetEmail = forgotPasswordAlert.textFields?.first?.text
            Auth.auth().sendPasswordReset(withEmail: resetEmail!, completion: { (Error) in
                if Error != nil
                {
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(Error!.localizedDescription) Please try again. ", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }
                else
                {
                    let resetEmailSentAlert = UIAlertController(title: "Reset Email Sent", message: "A password reset email has been sent to your registered Email address successfully. Please check your Email and follow the instruction.", preferredStyle: .alert)
                    resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetEmailSentAlert, animated: true, completion: nil)
                }
            })
            
        }))
    }
    
    // adjust sign-in selector when tapped
    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl)
    {
        
        isSignIn = !isSignIn // flip the boolean
        
        if isSignIn
        {
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        }
            
        else
        {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
        
    }
    
    
    // sign-in
    @IBAction func signInButtonTapped(_ sender: UIButton)
    {
        if let email = emailTextField.text, let pass = passwordTextField.text
        {
            // check if it's signin or register
            if isSignIn
            {
                // Sign in the user with Firebase
                Auth.auth().signIn(withEmail: email, password: pass, completion: { (User, Error) in
                    
                    // check that user isn't nil
                    if User != nil && Error == nil
                    {
                        // User has the correct credentials
                        if User!.isEmailVerified
                        {
                            // User is found, and Email address is verified, check if the user is signing in for the first time
                            self.performSegue(withIdentifier: "signInSuccessSegue", sender: self)
                        }
                        else
                        {
                            let notVerifiedAlert = UIAlertController(title: "Email Not Verified", message: "Your Email is pending verification. Please check your email and verify your account.", preferredStyle: .alert)
                            notVerifiedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(notVerifiedAlert, animated: true, completion: nil)
              
                             notVerifiedAlert.addAction(UIAlertAction(title: "Resend Verification Email", style: .default, handler:{ action in
                                self.sendVerificationEmail()}))

                            do
                            {
                                try Auth.auth().signOut()
                            }
                            catch
                            {
                                // Handle Error
                            }
                        }
                    }
                    else {
                        // Error: check error and show message
                        let signInError = UIAlertController(title: "Sign-in Error", message: "\(Error!.localizedDescription) Please try again. ", preferredStyle: .alert)
                        signInError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(signInError, animated: true, completion: nil)
                    }
                })
            }
                
            else
            {
                // Register the user with firebase
                Auth.auth().createUser(withEmail: email, password: pass, completion: { (User, Error) in
                    
                    // check that the user isn't nil
                    if User != nil && Error == nil {
                        // send the verification email
                        self.sendVerificationEmail()
                        // User is found, go to home screen
                //self.performSegue(withIdentifier: "goHome", sender: self)
                    
                    }
                    else {
                        // Error: check error and show message
                        let registerError = UIAlertController(title: "Registration Error", message: "\(Error!.localizedDescription) Please try again. ", preferredStyle: .alert)
                        registerError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(registerError, animated: true, completion: nil)
                        
                    }
                    
                    
                })
            }
        }
    }
    
    // send verification email function
    func sendVerificationEmail()
    {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!)
        {
            (User, Error) in
            if Error != nil
            {
                print("Internal Error: \(Error!.localizedDescription)")
                return
            }
            Auth.auth().currentUser?.sendEmailVerification(completion: { (Error) in
                if Error != nil
                {
                    let emailNotSentAlert = UIAlertController(title: "Email Verification Error", message: "Verification Email Failed to Send: \(Error!.localizedDescription)", preferredStyle: .alert)
                    emailNotSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(emailNotSentAlert, animated: true, completion: nil)
                }
                else
                {
                    let emailSentAlert = UIAlertController(title: "Email Verification", message: "Verification Email has been sent. Please check your Email and click the link to verify your account.", preferredStyle: .alert)
                    emailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(emailSentAlert, animated: true, completion: nil)
                }
            })
        }
        
        return
    }

    // hide keyboard when tapped around
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // Dismiss the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}
