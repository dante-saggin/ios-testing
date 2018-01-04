//
//  ViewController.swift
//  SwiftTrainning
//
//  Created by Dante Henrique Strutzel Saggin on 03/01/18.
//  Copyright © 2018 DHSS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    
    
    @IBOutlet weak var RetrivedValue: UILabel!
    @IBOutlet weak var RandomString: UILabel!
    
    
    @IBAction func GenerateRandomString(_ sender: Any) {

        if ((sender as AnyObject).tag) == 0{
            let mylocalString = randomString(length: 100)
            
            
            
            let value = KeyChain.stringToNSDATA(string: mylocalString)
            _ = KeyChain.save(key: "LongString", data: value as Data)
            
            RandomString.text = mylocalString
        } else if ((sender as AnyObject).tag == 1){
            if let receivedData = KeyChain.load(key: "LongString") {
                let result = KeyChain.NSDATAtoString(data: receivedData as NSData)
                RetrivedValue.text = result
            }
            
        }
        
    }
    
}

