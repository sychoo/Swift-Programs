//
//  mainPage.swift
//  LoginPage
//
//  Created by Administrator on 20/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseAuth

class MainPage: UIViewController {

    var docRef: DocumentReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = Auth.auth().currentUser
        if let user = user
        {
            let uid = user.uid
            let email = user.email
            
            // fetch the data from cloud
            docRef = Firestore.firestore().document("User/\(uid)/UserInfo/Profile")
            docRef.getDocument {(DocumentSnapshot, Error) in
                guard let docSnapshot = DocumentSnapshot, (DocumentSnapshot?.exists)! else { return }
                let myData = docSnapshot.data()
                let firstName = myData!["First Name"] as? String ?? "(none)"
                let lastName = myData!["Last Name"] as? String ?? "(none)"
                print("\n\n \(lastName), \(firstName)\n\n")
            }
            // test Cloud Firestore
           
            let db = Firestore.firestore()
                db.document("Users/\(uid)/UserInfo/Profile").setData(["name": "Los Angeles", "state": "CA"])
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    




}

