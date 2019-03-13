//
//  LSCThread.swift
//  Sample
//
//  Created by 冯鸿杰 on 2019/1/2.
//  Copyright © 2019年 vimfung. All rights reserved.
//

#if os(iOS)

import Foundation
import LuaScriptCore_iOS_Swift

#elseif os(OSX)

import Cocoa
import LuaScriptCore_OSX_Swift

#endif

@objc(LSCThread)
class LSCThread: NSObject, LuaExportType
{
    private var _handler : LuaFunction?
    private var _scriptController : LuaScriptController?
    
    @objc init(handler: LuaFunction)
    {
        _scriptController = LuaScriptController();
        _handler = handler;
    }
    
    @objc func run(arguments : Array<LuaValue>) -> Void
    {
        if (_handler != nil)
        {
            var args : Array<LSCValue> = Array<LSCValue>();
            for item in arguments {
                args.append(item.rawValue);
            }
            
            _handler?.context.runThread(with: _handler, arguments: args, scriptController: _scriptController);
        }
    }
    
    @objc func exit() -> Void
    {
        _scriptController?.forceExit();
    }
}
