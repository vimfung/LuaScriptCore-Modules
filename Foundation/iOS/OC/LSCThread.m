//
//  LSCThread.m
//  Sample
//
//  Created by 冯鸿杰 on 2018/12/29.
//  Copyright © 2018年 vimfung. All rights reserved.
//

#import "LSCThread.h"

@interface LSCThread ()

/**
 方法
 */
@property (nonatomic, strong) LSCFunction *handler;

@end

@implementation LSCThread

- (instancetype)initWithHandler:(LSCFunction *)handler
{
    if (self = [super init])
    {
        self.handler = handler;
    }
    
    return self;
}

- (void)run:(NSArray<LSCValue *> *)arguments
{
    if (self.handler)
    {
        [self.handler.context runThreadWithFunction:self.handler arguments:arguments];
    }
}

@end
