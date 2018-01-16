//
//  ViewController.swift
//  LoginPage
//
//  Created by Administrator on 14/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class ViewController: UIViewController {
    
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn:Bool = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
                    if User != nil {
                        // User is found, go to home screen
                        self.performSegue(withIdentifier: "goHome", sender: self)
                    }
                    else {
                        // Error: check error and show message
                    }
                })
            }
                
            else
            {
                // Register the user with firebase
                Auth.auth().createUser(withEmail: email, password: pass, completion: { (User, Error) in
                    
                    // check that the user isn't nil
                    if User != nil {
                        // User if ofund, go to home screen
                        self.performSegue(withIdentifier: "goHome", sender: self)
                    
                    }
                    else {
                        // Error: check error and show message
                        
                    }
                    
                    
                })
            }
        }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // Dismiss the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}
