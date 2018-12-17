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
}
