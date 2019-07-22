//
//  LSCEncoding.swift
//  Sample
//
//  Created by 冯鸿杰 on 2018/8/21.
//  Copyright © 2018年 vimfung. All rights reserved.
//

#if os(iOS)

import Foundation
import LuaScriptCore_iOS_Swift

#elseif os(OSX)

import Cocoa
import LuaScriptCore_OSX_Swift

#endif

@objc(LSCEncoding)
class LSCEncoding : NSObject, LuaExportType
{
    /// URL编码
    ///
    /// - Parameter text: 需要编码的文本
    /// - Returns: 编码后的文本
    @objc static func urlEncode(text : String) -> String?
    {
        return text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed);
    }
    
    /// URL解码
    ///
    /// - Parameter text: 需要解码的文本
    /// - Returns: 解码后的文本
    @objc static func urlDecode(text : String) -> String?
    {
        return text.removingPercentEncoding;
    }
    
    
    /// Base64编码
    ///
    /// - Parameter data: 需要编码的数据
    /// - Returns: 编码后的文本信息
    @objc static func base64Encode(data : Any) -> String?
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
        
        return rawData?.base64EncodedString();
    }
    
    /// Base64解码
    ///
    /// - Parameter text: 需要解码的文本信息
    /// - Returns: 解码后的数据
    @objc static func base64Decode(text : String) -> Data?
    {
        return Data(base64Encoded: text);
    }
    
    
    /// JSON编码
    ///
    /// - Parameter object: 需要编码的对象
    /// - Returns: 编码后的JSON字符串
    @objc static func jsonEncode(object : Any) -> String?
    {
        guard JSONSerialization.isValidJSONObject(object) else {
            return nil;
        }
        
        do
        {
            let data : Data = try JSONSerialization.data(withJSONObject: object, options: .init(rawValue: 0));
            return String(data: data, encoding: .utf8);
        }
        catch
        {
            return nil;
        }
    }
    
    
    /// JSON解码
    ///
    /// - Parameter jsonString: 需要解码的JSON字符串
    /// - Returns: 解码后的对象
    @objc static func jsonDecode(jsonString : String) -> Any?
    {
        let data : Data? = jsonString.data(using: .utf8);
        guard data != nil else {
            return nil;
        }
        
        do
        {
            return try JSONSerialization.jsonObject(with: data!, options: .init(rawValue: 0));
        }
        catch
        {
            return nil;
        }
        
    }
    
    
    /// 十六进制编码
    ///
    /// - Parameter data: 需要进行十六进制编码的数据
    /// - Returns: 编码后的字符串
    @objc static func hexEncode(data : Any) -> String?
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
        
        return rawData?.map { String(format: "%02hhx", $0 as CVarArg) }.joined();
    }
    
    /// 十六进制解码
    ///
    /// - Parameter string: 需要进行十六进制解码的字符串
    /// - Returns: 解码后数据
    @objc static func hexDecode(string : String) -> Data?
    {
        var bytes = [UInt8]()
        var sum = 0
        // 整形的 utf8 编码范围
        let intRange = 48...57
        // 小写 a~f 的 utf8 的编码范围
        let lowercaseRange = 97...102
        // 大写 A~F 的 utf8 的编码范围
        let uppercasedRange = 65...70
        for (index, c) in string.utf8CString.enumerated()
        {
            var intC = Int(c.byteSwapped)
            if intC == 0
            {
                break
            }
            else if intRange.contains(intC)
            {
                intC -= 48
            }
            else if lowercaseRange.contains(intC)
            {
                intC -= 87
            }
            else if uppercasedRange.contains(intC)
            {
                intC -= 55
            }
            else
            {
                return nil;
            }
            sum = sum * 16 + intC
            
            // 每两个十六进制字母代表8位，即一个字节
            if index % 2 != 0
            {
                bytes.append(UInt8(sum))
                sum = 0
            }
        }
        
        return Data(bytes: bytes);
    }
}
