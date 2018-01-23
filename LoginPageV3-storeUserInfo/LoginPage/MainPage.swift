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

var myIndex:Int!
let cellKey = ["First Name", "Last Name", "Bio", "Email", "Phone Number", "Password", "Country", "State/Province", "Birthdate", "Gender"]

class MainPage: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var docListener: ListenerRegistration!
    @IBOutlet weak var tableView: UITableView!
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
            
            // fetch the data from cloud
            docRef = Firestore.firestore().document("Users/\(uid)/UserInfo/Profile")
            docListener = docRef.addSnapshotListener {(docSnapshot, Error) in
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
                        self.cellValue.append("●●●●●●")
                    }
                    else
                    {
                        self.cellValue.append(myData![parameter] as? String ?? "(none)")
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.docListener.remove() // Enhance Performance
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
        //fetchData()
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        let keyStr: String! = cellKey[indexPath.row]
        let valueStr: String! = cellValue[indexPath.row]
        cell.textLabel?.text = keyStr + ": " + valueStr
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "updateSegue", sender: nil)
    }
    
}
