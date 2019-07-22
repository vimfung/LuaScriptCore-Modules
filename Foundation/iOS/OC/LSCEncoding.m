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

+ (NSString *)hexEncode:(id)data
{
    if (![data isKindOfClass:[NSData class]] && ![data isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    if ([data isKindOfClass:[NSString class]])
    {
        data = [data dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *hexStr = [NSMutableString string];
    const char *buf = [data bytes];
    for (int i = 0; i < [data length]; i++)
    {
        [hexStr appendFormat:@"%02x", buf[i] & 0xff];
    }
    return hexStr;
}

+ (NSData *)hexDecode:(NSString *)string
{
    if (![string isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    char byte = 0;
    
    NSString *upperString = [string uppercaseString];
    NSMutableData *data = [NSMutableData data];
    for (int i = 0; i < [upperString length]; i++)
    {
        NSInteger value = (NSInteger)[upperString characterAtIndex:i];
        if (value >= '0' && value <= '9')
        {
            if (i % 2 == 0)
            {
                byte = ((value - '0') << 4) & 0xf0;
                
                if (i == [upperString length] - 1)
                {
                    [data appendBytes:(const void *)&byte length:1];
                }
            }
            else
            {
                byte |= (value - '0') & 0x0f;
                [data appendBytes:(const void *)&byte length:1];
            }
        }
        else if (value >= 'A' && value <= 'F')
        {
            if (i % 2 == 0)
            {
                byte = ((value - 'A' + 10) << 4) & 0xf0;
                
                if (i == [upperString length] - 1)
                {
                    [data appendBytes:(const void *)&byte length:1];
                }
            }
            else
            {
                byte |= (value - 'A' + 10) & 0x0f;
                [data appendBytes:(const void *)&byte length:1];
            }
        }
        else
        {
            data = nil;
            break;
        }
    }
    
    return data;
}

@end
