//
//  LSCPath.swift
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

@objc(LSCPath)
class LSCPath : NSObject, LuaExportType
{
    
    /// 获取应用目录
    ///
    /// - Returns: 路径信息
    @objc static func app() -> String?
    {
        return Bundle.main.resourcePath;
    }
    
    /// 获取应用沙箱根目录
    ///
    /// - Returns: 路径信息
    @objc static func home() -> String?
    {
        return NSHomeDirectory();
    }
    
    /// 获取文档目录
    ///
    /// - Returns: 路径信息
    @objc static func docs() -> String?
    {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first;
    }
    
    /// 获取缓存目录
    ///
    /// - Returns: 路径信息
    @objc static func caches() -> String?
    {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first;
    }
    
    /// 获取临时目录
    ///
    /// - Returns: 路径信息
    @objc static func tmp() -> String?
    {
        return NSTemporaryDirectory();
    }
    
    
    /// 判断指定路径是否存在
    ///
    /// - Parameter path: 文件路径
    /// - Returns: True 存在，False 不存在
    @objc static func exists(path : String) -> Bool
    {
        return FileManager.default.fileExists(atPath:path);
    }
}
