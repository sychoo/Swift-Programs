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

class MainPage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var docRef: DocumentReference!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                let lastName = myData!["Last Name"] as? String ?? "(none)"
                print("\n\n \(lastName), \(firstName)\n\n")
        }
            
        

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
        }
        
        let cellDictionary = ["First Name": "Simon", "Last Name": "Chu"]
        for i in cellDictionary.keys
        {
            print(i)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Table View
    let array = ["Hello", "World"]
    let cellDict = ["First Name": "Simon", "Last Name": "Chu"]
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cellDict.count
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        let keyStr: String! = Array(cellDict.keys)[indexPath.row]
        let valueStr: String? = cellDict[Array(cellDict.keys)[indexPath.row]] as? String
        cell.textLabel?.text = keyStr + ": " + valueStr!
        
        return cell
    }

    




}

