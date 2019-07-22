//
//  LSCCrypto.m
//  Sample
//
//  Created by 冯鸿杰 on 2019/6/14.
//  Copyright © 2019年 vimfung. All rights reserved.
//

#import "LSCCrypto.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation LSCCrypto

+ (NSData *)md5:(id)data
{
    if (![data isKindOfClass:[NSData class]] && ![data isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    if ([data isKindOfClass:[NSString class]])
    {
        data = [data dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([data bytes], (CC_LONG)[data length], result);
    
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

+ (NSData *)sha1:(id)data
{
    if (![data isKindOfClass:[NSData class]] && ![data isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    if ([data isKindOfClass:[NSString class]])
    {
        data = [data dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1([data bytes], (CC_LONG)[data length], result);
    
    return [NSData dataWithBytes:result length:CC_SHA1_DIGEST_LENGTH];
}

+ (NSData *)hmacMD5:(id)data key:(id)key
{
    if (![data isKindOfClass:[NSData class]] && ![data isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    if (![key isKindOfClass:[NSData class]] && ![key isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    if ([data isKindOfClass:[NSString class]])
    {
        data = [data dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if ([key isKindOfClass:[NSString class]])
    {
        key = [key dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    void* buffer = malloc(CC_MD5_DIGEST_LENGTH);
    CCHmac(kCCHmacAlgMD5, [key bytes], [key length], [data bytes], [data length], buffer);
    return [NSData dataWithBytesNoCopy:buffer length:CC_MD5_DIGEST_LENGTH freeWhenDone:YES];
}

+ (NSData *)hmacSHA1:(id)data key:(id)key
{
    if (![data isKindOfClass:[NSData class]] && ![data isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    if (![key isKindOfClass:[NSData class]] && ![key isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    if ([data isKindOfClass:[NSString class]])
    {
        data = [data dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if ([key isKindOfClass:[NSString class]])
    {
        key = [key dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    void* buffer = malloc(CC_SHA1_DIGEST_LENGTH);
    CCHmac(kCCHmacAlgSHA1, [key bytes], [key length], [data bytes], [data length], buffer);
    return [NSData dataWithBytesNoCopy:buffer length:CC_SHA1_DIGEST_LENGTH freeWhenDone:YES];
}

@end
