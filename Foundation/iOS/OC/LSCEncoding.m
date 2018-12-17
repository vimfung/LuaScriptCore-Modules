//
//  Encoding.m
//  Sample
//
//  Created by 冯鸿杰 on 2018/8/20.
//  Copyright © 2018年 vimfung. All rights reserved.
//

#import "LSCEncoding.h"

@implementation LSCEncoding

+ (NSString *)urlEncode:(NSString *)string
{
    if (![string isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    NSString *newString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                    (CFStringRef)string,
                                                                                    NULL,
                                                                                    CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                    CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));

    return newString;
}

+ (NSString *)urlDecode:(NSString *)string
{
    if (![string isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    NSString *newString = [[string stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if (newString)
    {
        return newString;
    }
    
    return nil;
}

+ (NSString *)base64Encode:(id)data
{
    if (![data isKindOfClass:[NSData class]] && ![data isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    if ([data isKindOfClass:[NSString class]])
    {
        data = [data dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    return [data base64Encoding];
}

+ (NSData *)base64Decode:(NSString *)string;
{
    if (![string isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    return [[NSData alloc] initWithBase64Encoding:string];
}

+ (NSString *)jsonEncode:(id)object
{
    if (![NSJSONSerialization isValidJSONObject:object])
    {
        return nil;
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];

    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (id)jsonDecode:(NSString *)jsonString
{
    @try
    {
        return [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    }
    @catch (NSException *exception)
    {
        return nil;
    }
}

@end
