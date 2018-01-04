//
//  ViewController.swift
//  Is Prime
//
//  Created by Administrator on 03/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var displayField: UILabel!
    @IBAction func actionField(_ sender: Any)
    {
        
        let userEnteredText = textField.text
        let userEnteredInteger = Int(userEnteredText!)
        var isPrime = true
        
        if let number = userEnteredInteger
        {
            print(number, terminator:"")
            
            if number == 1
            {
                isPrime = false
            }
            else if number <= 0
            {
                isPrime = false
            }
            else
            {
                var i = 2
                while i < number
                {
                    if number % i == 0
                    {
                        isPrime = false
                        break
                    }
                    i += 1
                }
            }
            
            //forward data
            print(" \(isPrime)")

            //display
            if isPrime
            {
                displayField.text = "\(number) is Prime!"
            }
            else
            {
                displayField.text = "\(number) isn't Prime~"
            }
            

        }
       
        else
        {
            displayField.text = "Please Enter A Nonnegative Integer"
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

