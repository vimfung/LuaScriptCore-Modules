//
//  LSCPath.m
//  Sample
//
//  Created by 冯鸿杰 on 2018/8/21.
//  Copyright © 2018年 vimfung. All rights reserved.
//

#import "LSCPath.h"

@implementation LSCPath

+ (NSString *)app
{
    return [NSBundle mainBundle].resourcePath;
}

+ (NSString *)home
{
    return NSHomeDirectory();
}

+ (NSString *)docs
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)caches
{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)tmp
{
    return NSTemporaryDirectory();
}

+ (BOOL)exists:(NSString *)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

@end
