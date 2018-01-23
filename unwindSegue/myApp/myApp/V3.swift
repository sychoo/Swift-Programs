//
//  V3.swift
//  myApp
//
//  Created by Administrator on 15/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import Foundation
import UIKit

class V3: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func dismissCurrentVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  /*
    @IBAction func goBackToOneButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToV1", sender: self)
    }
   */
    
}
