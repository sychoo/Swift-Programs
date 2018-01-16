//
//  V2.swift
//  myApp
//
//  Created by Administrator on 15/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import Foundation
import UIKit

class V2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func goToNext(_ sender: Any)
    {
        performSegue(withIdentifier: "segueToV3", sender: self)
    }
    
    @IBAction func unwindToV2(segue:UIStoryboardSegue) { }
    
    
}
