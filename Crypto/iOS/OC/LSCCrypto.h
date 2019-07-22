//
//  LSCCrypto.h
//  Sample
//
//  Created by 冯鸿杰 on 2019/6/14.
//  Copyright © 2019年 vimfung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LuaScriptCore.h"

NS_ASSUME_NONNULL_BEGIN

/**
 加密工具类
 */
@interface LSCCrypto : NSObject <LSCExportType>

/**
 对数据使用MD5

 @param data 需要MD5的数据
 @return MD5后的数据
 */
+ (NSData *)md5:(id)data;


/**
 对数据使用SHA1

 @param data 需要SHA1的数据
 @return SHA1后的数据
 */
+ (NSData *)sha1:(id)data;


/**
 对数据使用HMAC-MD5

 @param data 需要HMAC-MD5的数据
 @param key 密钥
 @return HMAC-MD5后的数据
 */
+ (NSData *)hmacMD5:(id)data key:(id)key;


/**
 对数据使用HMAC-SHA1

 @param data 需要HMAC-SHA1的数据
 @param key 密钥
 @return HMAC-SHA1后的数据
 */
+ (NSData *)hmacSHA1:(id)data key:(id)key;

@end

NS_ASSUME_NONNULL_END
