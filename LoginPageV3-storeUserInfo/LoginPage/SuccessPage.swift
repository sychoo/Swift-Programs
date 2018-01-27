//
//  successPage.swift
//  LoginPage
//
//  Created by Administrator on 20/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//
// Display Email, UID, has Sign-out & go to main page function

import UIKit
import Firebase
//import FirebaseAuth

class SuccessPage: UIViewController {

    // the label that shows uid & email
    @IBOutlet weak var uidLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var isFirstTimeSignIn: UILabel!
    
    var docListener: ListenerRegistration! // for isFirstTimeSignIn
    var isFirstTimeSignInData = false // initialize to false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // display the uid and email address of the current user
        let user = Auth.auth().currentUser
        if let user = user
        {
            let uid = user.uid
            let email = user.email
            uidLabel.text = uid
            emailLabel.text = email
        }
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        var docRef: DocumentReference!
        
        // fetch the data from cloud
        let user = Auth.auth().currentUser
        if let user = user
        {
            let uid = user.uid
            //let email = user.email
            //let displayName = user.displayName
            //print(displayName)
            // fetch the data from cloud
            docRef = Firestore.firestore().document("Users/\(uid)/UserInfo/Logs")
            docListener = docRef.addSnapshotListener {(docSnapshot, Error) in
                guard let docSnapshot = docSnapshot, (docSnapshot.exists)
                    else
                {
                    let dataFetchingError = UIAlertController(title: "Data Fetching Error", message: "\(Error?.localizedDescription ?? "Could not fetch data at this moment.") Please try again. ", preferredStyle: .alert)
                    dataFetchingError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(dataFetchingError, animated: true, completion: nil)
                    return
                }
                let myData = docSnapshot.data()
                //print(myData?["isFirstTimeSignIn"])
                self.isFirstTimeSignInData = myData?["isFirstTimeSignIn"] as? Bool ?? false
                if (myData?["isFirstTimeSignIn"] as? Bool ?? false)
                {
                    self.isFirstTimeSignIn.text = "isFirstTime!!"
                }
                else
                {
                    self.isFirstTimeSignIn.text = "not the first time:("
                }
                //docRef.setData(["isFirstTimeSignIn" : false])
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        // Enhance Performance, remove unnecessary listener.
        self.docListener.remove()
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
            // sign out the user and catch errors
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
        else
        {
            // Alert: User has signed out
            let signOutErrorAlert = UIAlertController(title: "Sign-out Error", message: "User has signed out. Please go back to the login page.", preferredStyle: .alert)
            signOutErrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(signOutErrorAlert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func mainPageTapped(_ sender: Any)
    {
        if isFirstTimeSignInData
        {
            self.performSegue(withIdentifier: "isFirstTimeSignIn", sender: self)
        }
        else
        {
            self.performSegue(withIdentifier: "goToMain", sender: self)
        }
    }
    


}
