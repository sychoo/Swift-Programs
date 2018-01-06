//
//  ViewController.swift
//  Date and Time
//
//  Created by Administrator on 05/01/2018.
//  Copyright © 2018 Simon Chu. All rights reserved.
//

import UIKit

// https://stackoverflow.com/questions/27053135/how-to-get-a-users-time-zone
@objc extension ViewController
{
    func getLocalTime() -> String // function that get local time
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium // short, medium & long
        dateFormatter.timeStyle = .medium // short, medium & long
        dateFormatter.locale = Locale(identifier: "en_US")
        let str = dateFormatter.string(from: date)
        return str
    }
    
    func getBeijingTime() -> String // function that get local time
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT:28000)
        dateFormatter.dateStyle = .medium // short, medium & long
        dateFormatter.timeStyle = .medium // short, medium & long
        dateFormatter.locale = Locale(identifier: "zh_CN")
        let str = dateFormatter.string(from: date)
        return str
    }
    
    func getGMTshift() -> Int // function that returns GMT shift (seconds)
    {
        return TimeZone.current.secondsFromGMT()
        
    }
    
    func getGMTstr() -> String
    {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //dateFormatter.timeZone = TimeZone(identifier:"GMT")
        dateFormatter.timeZone = TimeZone(secondsFromGMT:28000)
        let defaultTimeZoneStr = dateFormatter.string(from: date)
        
        return defaultTimeZoneStr
    }
    
    func localTimeZone() -> String
    {
        let str1 = TimeZone.current.identifier
        let str2 = TimeZone.current.abbreviation() ?? ""
        let str3 = TimeZone.current.secondsFromGMT()

        return str1 + " " + str2 + " GMT\(str3 / 3600)"
    }
    
    func BeijingTimeZone() -> String
    {
        let value = "HKT"
        let date = Date()
        let TZ = TimeZone.init(abbreviation: "KST") //HKT "Asia/HongKong"
        let str1 = TZ?.identifier
        let str2 = TZ?.abbreviation() ?? ""
       // let str3 = TZ?.secondsFromGMT()
        //var timeZoneAbbreviations: [String:String] { return TimeZone.abbreviationDictionary }
        //print(timeZoneAbbreviations)
        print("\(TZ?.abbreviation(for: date))")
        
        return str1! + " " + str2//+ " GMT\(str3! / 3600)"
    }

    func updateLocal()
    {
        Label.text = getLocalTime()
    }
/*
    func updateBeijing()
    {
        Label2.text = getBeijingTime()
    }
  */
}


class ViewController: UIViewController
{

    @IBOutlet var Label: UILabel!
    var timer = Timer()


    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // run the function every 0.1 second
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateLocal), userInfo: nil, repeats: true)
        print("\(getGMTstr())")
        print("\(localTimeZone())")
        print("\(BeijingTimeZone())")
        

        
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

