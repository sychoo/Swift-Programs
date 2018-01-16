//
//  ViewController.swift
//  myApp
//
//  Created by Administrator on 15/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit

class V1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func goToNext(_ sender: Any)
    {
        performSegue(withIdentifier: "segueToV2", sender: self)
    }
    
    @IBAction func unwindToV1(segue:UIStoryboardSegue) { }
    
}

