//
//  LSCThread.h
//  Sample
//
//  Created by 冯鸿杰 on 2018/12/29.
//  Copyright © 2018年 vimfung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LuaScriptCore.h"

NS_ASSUME_NONNULL_BEGIN

@class LSCScriptController;

/**
 线程
 */
@interface LSCThread : NSObject <LSCExportType>

/**
 初始化

 @param handler 处理器
 @return 线程对象
 */
- (instancetype)initWithHandler:(LSCFunction *)handler;

/**
 启动线程

 @param arguments 线程参数
 */
- (void)run:(NSArray<LSCValue *> *)arguments;

/**
 退出线程
 */
- (void)exit;

@end

NS_ASSUME_NONNULL_END
