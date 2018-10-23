//
//  LSCPath.h
//  Sample
//
//  Created by 冯鸿杰 on 2018/8/21.
//  Copyright © 2018年 vimfung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LuaScriptCore.h"

/**
 路径信息
 */
@interface LSCPath : NSObject <LSCExportType>

/**
 应用程序所在目录

 @return 路径信息
 */
+ (NSString *)app;

/**
 应用的沙箱根目录

 @return 路径信息
 */
+ (NSString *)home;

/**
 应用的文档目录

 @return 路径信息
 */
+ (NSString *)docs;

/**
 应用的缓存目录

 @return 路径信息
 */
+ (NSString *)caches;


/**
 获取临时目录

 @return 路径信息
 */
+ (NSString *)tmp;

/**
 判断是否存在路径

 @param path 路径
 @return YES 表示存在，NO 表示不存在
 */
+ (BOOL)exists:(NSString *)path;

@end
