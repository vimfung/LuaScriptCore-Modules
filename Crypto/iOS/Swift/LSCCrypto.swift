//
//  LSCCrypto.swift
//  Sample
//
//  Created by 冯鸿杰 on 2019/6/16.
//  Copyright © 2019年 vimfung. All rights reserved.
//

import CommonCrypto

#if os(iOS)

import Foundation
import LuaScriptCore_iOS_Swift

#elseif os(OSX)

import Cocoa
import LuaScriptCore_OSX_Swift

#endif

@objc class LSCCrypto: NSObject, LuaExportType
{
    
    /// 对数据使用MD5
    ///
    /// - Parameter data: 需要MD5的数据
    /// - Returns: MD5后的数据
    @objc static func md5(data : Any) -> Data?
    {
        guard data is Data || data is String else {
            return nil;
        }
        
        var rawData : Data? = nil;
        
        if data is String
        {
            rawData = (data as! String).data(using: .utf8);
        }
        else
        {
            rawData = data as? Data;
        }
        
        let pointer = rawData?.withUnsafeBytes({ (dataPointer: UnsafePointer<Int8>) in
            
            return dataPointer;
            
        });
        
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_MD5_DIGEST_LENGTH));
        CC_MD5(pointer,(CC_LONG)(strlen(pointer)), buffer)

        let result = Data(bytes: buffer, count: Int(CC_MD5_DIGEST_LENGTH));
        
        free(buffer);
        
        return result;
    }
    
    
    /// 对数据使用SHA1
    ///
    /// - Parameter data: 需要SHA1的数据
    /// - Returns: SHA1后的数据
    @objc static func sha1(data : Any) -> Data?
    {
        guard data is Data || data is String else {
            return nil;
        }
        
        var rawData : Data? = nil;
        
        if data is String
        {
            rawData = (data as! String).data(using: .utf8);
        }
        else
        {
            rawData = data as? Data;
        }
        
        let pointer = rawData?.withUnsafeBytes({ (dataPointer: UnsafePointer<Int8>) in
            
            return dataPointer;
            
        });
        
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_SHA1_DIGEST_LENGTH));
        CC_SHA1(pointer, (CC_LONG)(strlen(pointer)), buffer);
        
        let result = Data(bytes: buffer, count: Int(CC_SHA1_DIGEST_LENGTH));
        
        free(buffer);
        
        return result;
    }
    
    
    /// 对数据使用HMAC-MD5
    ///
    /// - Parameters:
    ///   - data: 需要进行HMAC-MD5的数据
    ///   - key: 密钥
    /// - Returns: HMAC-MD5后的数据
    @objc static func hmacMD5(data : Any, key : Any) -> Data?
    {
        guard data is Data || data is String else {
            return nil;
        }
        
        guard key is Data || key is String else {
            return nil;
        }
        
        var rawData : Data? = nil;
        
        if data is String
        {
            rawData = (data as! String).data(using: .utf8);
        }
        else
        {
            rawData = data as? Data;
        }
        
        var rawKey : Data? = nil;
        
        if key is String
        {
            rawKey = (key as! String).data(using: .utf8);
        }
        else
        {
            rawKey = key as? Data;
        }
        
        let dp = rawData?.withUnsafeBytes({ (dataPointer: UnsafePointer<Int8>) in
            return dataPointer;
        });
        
        let kp = rawKey?.withUnsafeBytes({ (keyPointer : UnsafePointer<Int8>) in
            return keyPointer;
        });
        
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_MD5_DIGEST_LENGTH));
        CCHmac(CCHmacAlgorithm(kCCHmacAlgMD5), kp, Int(strlen(kp)), dp, Int(strlen(dp)), buffer);
        
        let result = Data(bytes: buffer, count: Int(CC_MD5_DIGEST_LENGTH));
        
        free(buffer);
        
        return result;
    }
    
    
    /// 对数据使用HMAC-SHA1
    ///
    /// - Parameters:
    ///   - data: 需要进行HMAC-SHA1的数据
    ///   - key: 密钥
    /// - Returns: HMAC-SHA1后的数据
    @objc static func hmacSHA1(data : Any, key : Any) -> Data?
    {
        guard data is Data || data is String else {
            return nil;
        }
        
        guard key is Data || key is String else {
            return nil;
        }
        
        var rawData : Data? = nil;
        
        if data is String
        {
            rawData = (data as! String).data(using: .utf8);
        }
        else
        {
            rawData = data as? Data;
        }
        
        var rawKey : Data? = nil;
        
        if key is String
        {
            rawKey = (key as! String).data(using: .utf8);
        }
        else
        {
            rawKey = key as? Data;
        }
        
        let dp = rawData?.withUnsafeBytes({ (dataPointer: UnsafePointer<Int8>) in
            return dataPointer;
        });
        
        let kp = rawKey?.withUnsafeBytes({ (keyPointer : UnsafePointer<Int8>) in
            return keyPointer;
        });
        
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: Int(CC_SHA1_DIGEST_LENGTH));
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), kp, Int(strlen(kp)), dp, Int(strlen(dp)), buffer);
        
        let result = Data(bytes: buffer, count: Int(CC_SHA1_DIGEST_LENGTH));
        
        free(buffer);
        
        return result;
    }
}
