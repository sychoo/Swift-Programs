//
//  ViewController.swift
//  FirstProgram
//
//  Created by Administrator on 03/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var yearField: UILabel!
    @IBOutlet var textField: UITextField!
    @IBAction func button(_ sender: Any) {
        let a = Int(textField.text!)! * 7
        yearField.text = String(a)
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

