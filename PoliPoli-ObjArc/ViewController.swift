//
//  ViewController.swift
//  PoliPoli-ObjArc
//
//  Created by Tatsuya Moriguchi on 11/29/17.
//  Copyright © 2017 Becko's Inc. All rights reserved.
//  THIS IS A TEST.

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var goalData:[UITextField]!
    
    func dataFileURL() -> NSURL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var url:NSURL?
        url = URL(fileURLWithPath: "") as NSURL?
        
        do {
            try url = urls.first!.appendingPathComponent("data.plist") as NSURL?
        } catch {
            print("Error is \(error), Hello")
        }
        return url!
    }
    // hello
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let fileURL = self.dataFileURL()
        if(FileManager.default.fileExists(atPath: fileURL.path!)) {
            if let array = NSArray(contentsOf: fileURL as URL) as? [String] {
                for i in 0..<array.count {
                    goalData[i].text = array[i]
                }
            }
        }
        
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)), name: Notification.Name.UIApplicationWillResignActive, object: app)
    }
    
    func applicationWillResignActive(notification:NSNotification) {
        let fileURL = self.dataFileURL()
        let array = (self.goalData as NSArray).value(forKey: "text") as! NSArray
        array.write(to: fileURL as URL, atomically: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

