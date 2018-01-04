//
//  KeyChain.swift
//  SwiftTrainning
//
//  Created by Dante Henrique Strutzel Saggin on 03/01/18.
//  Copyright © 2018 DHSS. All rights reserved.
//

import Foundation


class KeyChain {
    
    class func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]
        
        SecItemDelete(query as CFDictionary)
        
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    class func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef: AnyObject? = nil
        
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    class func stringToNSDATA(string : String)->NSData
    {
        let _Data = (string as NSString).data(using: String.Encoding.utf8.rawValue)
        return _Data! as NSData
        
    }
    
    
    class func NSDATAtoString(data: NSData)->String
    {
        let returned_string : String = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
        return returned_string
    }
    
    class func intToNSDATA(r_Integer : Int)->NSData
    {
        
        var SavedInt: Int = r_Integer
        let _Data = NSData(bytes: &SavedInt, length: MemoryLayout<Int>.size)
        return _Data
        
    }
    class func NSDATAtoInteger(_Data : NSData) -> Int
    {
        var RecievedValue : Int = 0
        _Data.getBytes(&RecievedValue, length: MemoryLayout<Int>.size)
        return RecievedValue
        
    }
    
    
    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)
        
        let swiftString: String = cfStr as String
        return swiftString
    }
    
    
    
    
}

extension Data {
    
    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
    
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.pointee }
    }
}
