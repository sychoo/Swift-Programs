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

let cellKey = ["First Name", "Last Name", "Bio", "Email", "Phone Number", "Password", "Country", "State/Province", "Birthdate", "Gender"]
var cellValue:Array<String> = []
var myIndex:Int!

class MainPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
 

    var docListener: ListenerRegistration!

    
    @IBOutlet weak var tableView: UITableView!

    //let segueID = ["segue1", "segue2", "segue3", "segue4", "segue5", "segue6", "segue7", "segue8", "segue9", "segue10"]
    //var cellValue = ["","","","","","","",""]

    
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
                guard let docSnapshot = docSnapshot, (docSnapshot.exists)
                    else
                {
                    let dataFetchingError = UIAlertController(title: "Data Fetching Error", message: "\(Error!.localizedDescription) Please try again. ", preferredStyle: .alert)
                    dataFetchingError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(dataFetchingError, animated: true, completion: nil)
                    return
                }
                let myData = docSnapshot.data()
                
                for parameter in cellKey
                {
                    if parameter == "Password"
                    {
                        cellValue.append("●●●●●●")
                    }
                    else
                    {
                        cellValue.append(myData![parameter] as? String ?? "(none)")
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
    

        //self.tableView.reloadData()
        //docListener.remove()
  /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
                guard let docSnapshot = docSnapshot, (docSnapshot.exists)
                    else
                {
                    let dataFetchingError = UIAlertController(title: "Data Fetching Error", message: "\(Error!.localizedDescription) Please try again. ", preferredStyle: .alert)
                    dataFetchingError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(dataFetchingError, animated: true, completion: nil)
                    return
                }
                let myData = docSnapshot.data()
                
                for parameter in cellKey
                {
                    if parameter == "Password"
                    {
                        cellValue.append("●●●●●●")
                    }
                    else
                    {
                        cellValue.append(myData![parameter] as? String ?? "(none)")
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
       // self.tableView.reloadData()
    }
 */
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        myIndex = indexPath.row
        performSegue(withIdentifier: "updateSegue", sender: self)
        //self.tableView.reloadData()
    }
    
//@IBAction func unwindToV2(segue:UIStoryboardSegue) { }
    
}

