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
    var dict: [String:String]
    {
        return TimeZone.abbreviationDictionary
    }
    
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
        let value = "Asia/Hong_Kong" // abbreviation or identifier///////////////////////////
        let date = Date()
        let dateFormatter = DateFormatter()
        //dateFormatter.timeZone = TimeZone(secondsFromGMT:28800)
        if value.contains("/")
        {
            dateFormatter.timeZone = TimeZone(identifier: value)
        }
        
        else
        {
            dateFormatter.timeZone = TimeZone(abbreviation: value)
        }

        dateFormatter.dateStyle = .medium // short, medium & long
        dateFormatter.timeStyle = .medium // short, medium & long
        dateFormatter.locale = Locale(identifier: "zh_CN")
        let str = dateFormatter.string(from: date)
        return str
    }
    
    func getLocalGMTshift() -> Int // function that returns GMT shift (seconds)
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
        let val = TimeZone.current.identifier
        
       // let str2 = TimeZone.current.abbreviation() ?? ""
        
        let GMT = TimeZone.current.secondsFromGMT()
        var key = ""
        var str = ""

        for i in dict.keys
        {
            if val == dict[i]
            {
                key = i
            }
        }
        
        if GMT < 0
        {
            str = val + " " + key + " GMT\(GMT / 3600)"
        }
            
        else if GMT > 0
        {
            str = val + " " + key + " GMT+\(GMT / 3600)"
        }
            
        else
        {
            str = val + " " + key + " GMT \(GMT / 3600)"
        }
        
        return str
    }
    
    func BeijingTimeZone() -> String
    {
        let value = "Asia/Hong_Kong" // Put TimeZone Identifier or Abbreviation
        
        //print(TimeZone.abbreviationDictionary)
        var key = ""
        var val = ""
        var str = ""
        
        if value.contains("/")
        {
            val = value
            for i in dict.keys
            {
                if val == dict[i]
                {
                    key = i
                }
            }
        }
        
        else
        {
            key = value
            val = dict[key]!
        }
        
        let TZ = TimeZone.init(abbreviation: key) // i.e. HKT
        let GMT = TZ?.secondsFromGMT()
        
        if GMT! < 0
        {
            str = val + " " + key + " GMT\(GMT! / 3600)"
        }
            
        else if GMT! > 0
        {
            str = val + " " + key + " GMT+\(GMT! / 3600)"
        }
        
        else
        {
            str = val + " " + key + " GMT \(GMT! / 3600)"
        }
        
        return str
    }

    func updateLocal()
    {
        Label.text = getLocalTime()
    }

    func updateBeijing()
    {
        Label2.text = getBeijingTime()
    }

}


class ViewController: UIViewController
{
    @IBOutlet var Label: UILabel!
    @IBOutlet var Label2: UILabel!
    @IBOutlet var timeZone: UILabel!
    @IBOutlet var timeZone2: UILabel!
    
    var timer = Timer()
    var timer2 = Timer()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // run the function every 0.1 second
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateLocal), userInfo: nil, repeats: true)
       timer2 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateBeijing), userInfo: nil, repeats: true)
   
        timeZone.text = localTimeZone()
        timeZone2.text = BeijingTimeZone()
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
         
         var timeZoneAbbreviations: [String:String] { return TimeZone.abbreviationDictionary }
         print(timeZoneAbbreviations)
         
         let str1 = TZ?.identifier()
         let str2 = TZ?.abbreviation()
         */
        
        // TimeZone.abbreviationDictionary
        /*  ["CEST": "Europe/Paris", "CDT": "America/Chicago", "EET": "Europe/Athens", "CET": "Europe/Paris", "KST": "Asia/Seoul", "CLT": "America/Santiago", "HST": "Pacific/Honolulu", "CST": "America/Chicago", "CAT": "Africa/Harare", "BRT": "America/Sao_Paulo", "JST": "Asia/Tokyo", "GST": "Asia/Dubai", "PHT": "Asia/Manila", "BST": "Europe/London", "PST": "America/Los_Angeles", "ART": "America/Argentina/Buenos_Aires", "WAT": "Africa/Lagos", "EST": "America/New_York", "BDT": "Asia/Dhaka", "TRT": "Europe/Istanbul", "CLST": "America/Santiago", "AKST": "America/Juneau", "PKT": "Asia/Karachi", "ICT": "Asia/Bangkok", "MSK": "Europe/Moscow", "EAT": "Africa/Addis_Ababa", "WEST": "Europe/Lisbon", "BRST": "America/Sao_Paulo", "EEST": "Europe/Athens", "MSD": "Europe/Moscow", "MST": "America/Phoenix", "NZDT": "Pacific/Auckland", "PET": "America/Lima", "NST": "America/St_Johns", "NDT": "America/St_Johns", "MDT": "America/Denver", "NZST": "Pacific/Auckland", "COT": "America/Bogota", "WET": "Europe/Lisbon", "SGT": "Asia/Singapore", "IST": "Asia/Kolkata", "HKT": "Asia/Hong_Kong", "UTC": "UTC", "EDT": "America/New_York", "WIT": "Asia/Jakarta", "IRST": "Asia/Tehran", "AKDT": "America/Juneau", "PDT": "America/Los_Angeles", "ADT": "America/Halifax", "AST": "America/Halifax", "GMT": "GMT"]
         */
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

