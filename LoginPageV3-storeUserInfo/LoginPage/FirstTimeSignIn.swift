//
//  FirstTimeSignIn.swift
//  LoginPage
//
//  Created by Administrator on 25/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit

class FirstTimeSignIn: UIViewController {

    @IBAction func continueTapped(_ sender: Any)
    {
        performSegue(withIdentifier: "goToMainScreen", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
