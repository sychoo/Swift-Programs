//
//  ViewController.swift
//  Cat Year
//
//  Created by Administrator on 03/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var yearField: UILabel!
    @IBAction func buttonTapped(_ sender: Any) {
        
        let userEnteredText = textField.text
        let userEnteredInteger = Int(userEnteredText!)
        
        if let catAge = userEnteredInteger {
            yearField.text = String(catAge * 7)
            print("Output: " + yearField.text!)
        } else{
            yearField.text = "Please Enter A Nonnegative Integer"
            print("Error")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

