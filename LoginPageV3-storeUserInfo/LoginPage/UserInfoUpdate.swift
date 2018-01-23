//
//  UserInfo.swift
//  LoginPage
//
//  Created by Administrator on 22/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit
import Firebase

class UserInfoUpdate: UIViewController {

    //let cellKey = ["First Name", "Last Name", "Email", "Phone Number", "Password", "Country", "State", "Birthdate"]
    //var cellValue = ["", "", "", "", "", "", "", ""]
    //var firstName, lastName, email, phoneNumber, password, country, state, DOB: String?
    //var cellValue = ["First Name", "Last Name", "Email", "Phone Number", "Password", "Country", "State", "Birthdate"]
    //let cellValue = fetchData()

    //var cellValue:Array<String> = []
    
    var docRef: DocumentReference!
    var parameter = cellKey[myIndex]
    @IBOutlet weak var parameterLabel: UILabel!

    @IBOutlet weak var textField: UITextField!
    
    @IBAction func saveTapped(_ sender: Any)
    {
        let user = Auth.auth().currentUser
        if let user = user
        {
            let uid = user.uid
            docRef = Firestore.firestore().document("Users/\(uid)/UserInfo/Profile")
            //  db.document("Users/\(uid)/UserInfo/Profile").setData(["name": "Los Angeles", "state": "CA"])
            //db.collection("Users").document(uid).collection("UserInfo").document("Profile").setData(["name": "Los Angeles", "state": "CA"])
            docRef.setData(["\(parameter)": textField?.text! ?? ""], options: SetOptions.merge()) {(error: Error?) in
                if let error = error {
                    print("\(error.localizedDescription)")
                }
                else{
                    print("Data Saved!")
                }
            }
        }
        //performSegue(withIdentifier: "unwindSegueToV2", sender: self)
        //MainPage().loadCell()
        self.dismiss(animated: true, completion: nil)
        
        //MainPage().tableView.reloadData()
        
    }
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    @IBAction func cancelTapped(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
        
        //performSegue(withIdentifier: "goBack", sender: self)
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        //MainPage().tableView.reloadData()
    }
 */
    override func viewDidLoad() {
        super.viewDidLoad()
        parameterLabel.text = parameter
        textField.placeholder = "Please Enter Your \(cellKey[myIndex])"

    }
 


// test Cloud Firestore
/*
 let db = Firestore.firestore()
 //  db.document("Users/\(uid)/UserInfo/Profile").setData(["name": "Los Angeles", "state": "CA"])
 db.document("Users/\(uid)/UserInfo/Profile").setData(["state": "New York"], options: SetOptions.merge())
 //db.collection("Users").document(uid).collection("UserInfo").document("Profile").setData(["name": "Los Angeles", "state": "CA"])
 {(error: Error?) in if let error = error
 {
 print("\(error.localizedDescription)")
 }
 else{
 print("Data Saved!")
 }
 }
    }
*/
 /*
        // fetch the data from cloud
        let user = Auth.auth().currentUser
        if let user = user
        {
            let uid = user.uid
            //let email = user.email
            
            // fetch the data from cloud
            
            docRef = Firestore.firestore().document("Users/\(uid)/UserInfo/Profile")
            docRef.addSnapshotListener {(docSnapshot, Error) in
                guard let docSnapshot = docSnapshot, (docSnapshot.exists) else { print("I'm Here");return }
                let myData = docSnapshot.data()
                let firstName = myData!["First Name"] as? String ?? "(none)"
                 self.cellValue.append(firstName)
                //MainPage().tableView.reloadData()
                //self.firstName = myData!["First Name"] as? String ?? "(none)"
                //self.cellValue[0] = firstName
                //self.tableView.reloadData()
                print("\(self.cellValue)")
                let lastName = myData!["Last Name"] as? String ?? "(none)"
                //print("\n\n \(lastName), \(firstName)\n\n")
            }
            
   */
            
            /*         docRef = Firestore.firestore().document("Users/\(uid)/UserInfo/Profile")
             docRef.addSnapshotListener { documentSnapshot, error in
             guard let document = documentSnapshot else {
             print("Error fetching document: \(error!)")
             return
             }
             print("Current data: \(document.data())")
             }
             */
            // test Cloud Firestore
            /*
             let db = Firestore.firestore()
             //  db.document("Users/\(uid)/UserInfo/Profile").setData(["name": "Los Angeles", "state": "CA"])
             db.document("Users/\(uid)/UserInfo/Profile").setData(["state": "New York"], options: SetOptions.merge())
             //db.collection("Users").document(uid).collection("UserInfo").document("Profile").setData(["name": "Los Angeles", "state": "CA"])
             {(error: Error?) in if let error = error
             {
             print("\(error.localizedDescription)")
             }
             else{
             print("Data Saved!")
             }
             }
             */
            
        
        //self.tableView.addSubview(self.refreshControl)
        // self.refreshControl?.addTarget(self, action: #selector(UIViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        // Table View
        //let array = ["Hello", "World"]
        //let cellDict = ["First Name": "Simon", "Last Name": "Chu"]
        
        
        
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.


    //var cellValue = [firstName.self, lastName, firstName, lastName, email, phoneNumber, password, country, state, DOB]
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
