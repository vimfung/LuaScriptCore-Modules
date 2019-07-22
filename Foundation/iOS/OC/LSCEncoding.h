//
//  Encoding.h
//  Sample
//
//  Created by 冯鸿杰 on 2018/8/20.
//  Copyright © 2018年 vimfung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LuaScriptCore.h"

/**
 编码工具类型
 */
@interface LSCEncoding : NSObject <LSCExportType>

/**
 *  URL编码
 *
 *  @param string   原始字符串
 *
 *  @return 编码后字符串
 */
+ (NSString *)urlEncode:(NSString *)string;

/**
 *  URL解码
 *
 *  @param string   原始字符串
 *
 *  @return 解码后字符串
 */
+ (NSString *)urlDecode:(NSString *)string;


/**
 Base64编码

 @param data 原始数据
 @return 编码后字符串
 */
+ (NSString *)base64Encode:(id)data;


/**
 Base64解码

 @param string 原始字符串
 @return 编码后字符串
 */
+ (NSData *)base64Decode:(NSString *)string;


/**
 JSON编码

 @param object 需要编码的对象
 @return 编码后的JSON字符串
 */
+ (NSString *)jsonEncode:(id)object;


/**
 JSON解码

 @param jsonString 需要解码的JSON字符串
 @return 解码后的对象
 */
+ (id)jsonDecode:(NSString *)jsonString;

/**
 十六进制编码

 @param data 需要转换成十六进制表示的数据
 @return 编码后字符串
 */
+ (NSString *)hexEncode:(id)data;


/**
 十六进制解码

 @param string 需要还原回数据的十六进制字符串
 @return 解码后数据
 */
+ (NSData *)hexDecode:(NSString *)string;

@end
