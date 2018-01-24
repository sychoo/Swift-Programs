//
//  MainPage.swift
//  LoginPage
//
//  Created by Administrator on 20/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseAuth

var displayName: String?
var myIndex: Int!
let cellKey = ["First Name", "Last Name", "Bio", "Email", "Phone Number", "Password", "Country", "State/Province", "Birthdate", "Gender"]

class MainPage: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBAction func deleteButtonTapped(_ sender: Any)
    {
        // Delete Account Action
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
    @IBOutlet weak var tableView: UITableView!
    var docListener: ListenerRegistration!
    
    var cellValue:Array<String> = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Display only an arrow in the next ViewController navigation bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        
        
        // Update Non-database user profile
        let userProfile = Auth.auth().currentUser
        if let user = userProfile {
            let changeRequest = user.createProfileChangeRequest()
            // change request: displayName
            changeRequest.displayName = displayName
            changeRequest.commitChanges { Error in
                if Error != nil {
                    let userProfileChangingError = UIAlertController(title: "User Profile Changing Error", message: "\(Error?.localizedDescription ?? "Could not change user profile at this moment.") Please try again. ", preferredStyle: .alert)
                    userProfileChangingError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(userProfileChangingError, animated: true, completion: nil)
                    return
                } else {
                    // Profile updated.
                }
            }
        }
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
            docRef = Firestore.firestore().document("Users/\(uid)/UserInfo/Profile")
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
                
                self.cellValue = []
                
                for parameter in cellKey
                {
                    // append dots for password cell
                    if parameter == "Password"
                    {
                        self.cellValue.append("●●●●●●")
                    }
                        
                    else
                    {
                        // set displayName = First Name
                        if parameter == "First Name"
                        {
                            // provide default displayName = ""
                            displayName = myData![parameter] as? String ?? ""
                        }
                        self.cellValue.append(myData![parameter] as? String ?? "(none)")
                    }
                }
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        // Enhance Performance, remove unnecessary listener.
        self.docListener.remove()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //fetchData()
        let value = min(cellValue.count, cellKey.count)
        return value
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // feed data to the table view cells
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        let keyStr: String! = cellKey[indexPath.row]
        let valueStr: String! = cellValue[indexPath.row]
        cell.textLabel?.text = keyStr + ": " + valueStr
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row

        let parameter1 = cellKey[myIndex]
        
        // show the corresponding segue for updating parameter
        if parameter1 == "Password"
        {
            performSegue(withIdentifier: "passwordUpdateSegue", sender: self)
        }
            
        else if parameter1 == "Email"
        {
            performSegue(withIdentifier: "emailUpdateSegue", sender: self)
        }
            
        else if parameter1 == "Phone Number"
        {
            performSegue(withIdentifier: "phoneNumberUpdateSegue", sender: self)
        }
            
        else
        {
            performSegue(withIdentifier: "updateSegue", sender: self)
        }
    }
    
}
