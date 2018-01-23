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
    

    @IBOutlet weak var tableView: UITableView!
    let cellKey = ["First Name", "Last Name", "Email", "Phone Number", "Password", "Country", "State/Province", "Birthdate", "Gender", "Bio"]
    let segueID = ["segue1", "segue2", "segue3", "segue4", "segue5", "segue6", "segue7", "segue8", "segue9", "segue10"]
    //var cellValue = ["","","","","","","",""]
    var cellValue:Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Display only an arrow in the next ViewController navigation bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        var docRef: DocumentReference!
        
        
        
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
            
                for parameter in self.cellKey
                {
                    if parameter == "Password"
                    {
                        self.cellValue.append("●●●●●●")
                    }
                    else
                    {
                        self.cellValue.append(myData![parameter] as? String ?? "(none)")
                    }
                }
                    /*
                self.cellValue.append(myData!["First Name"] as? String ?? "(none)")
                self.cellValue.append(myData!["Last Name"] as? String ?? "(none)")
                self.cellValue.append(myData!["Email"] as? String ?? "(none)")
                self.cellValue.append(myData!["Phone Number"] as? String ?? "(none)")
                self.cellValue.append("●●●●●●")
                self.cellValue.append(myData!["Country"] as? String ?? "(none)")
                self.cellValue.append(myData!["State"] as? String ?? "(none)")
                self.cellValue.append(myData!["Birthdate"] as? String ?? "(none)")
                self.cellValue.append(myData!["Gender"] as? String ?? "(none)")
          */
                //print("\n\n \(lastName), \(firstName)\n\n")
               // self.tableView.reloadData()
            }

    }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
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
        //fetchData()
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        let keyStr: String! = cellKey[indexPath.row]
        let valueStr: String! = cellValue[indexPath.row]
        cell.textLabel?.text = keyStr + ": " + valueStr
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueID[indexPath.row], sender: nil)
    }
    
    
    
    
}
