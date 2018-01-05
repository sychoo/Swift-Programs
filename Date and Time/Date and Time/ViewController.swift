//
//  ViewController.swift
//  Date and Time
//
//  Created by Administrator on 05/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var Label: UILabel!
    
    var timer = Timer()
    
    @objc func getTime()
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .long
        dateFormatter.locale = Locale(identifier: "en_US")
        let timeStr = dateFormatter.string(from: date)
        Label.text = timeStr
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.getTime), userInfo: nil, repeats: true)
        /*
         let calendar = Calendar.current
         let hours = calendar.component(.hour, from: date)
         let minutes = calendar.component(.minute, from: date)
         let seconds = calendar.component(.second, from: date)
         
         print("\(hours) : \(minutes) : \(seconds)")
         
         
         let days = calendar.component(.day, from: date)
         let months = calendar.component(.month, from: date)
         let years = calendar.component(.year, from: date)
         
         print("\(month) / \(months) / \(years)")
         */
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

