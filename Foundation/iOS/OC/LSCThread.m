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
@property (nonatomic, strong) LSCFunction *_handler;

/**
 执行脚本
 */
@property (nonatomic, strong) LSCScriptController *_scriptController;

@end

@implementation LSCThread

- (instancetype)initWithHandler:(LSCFunction *)handler
{
    if (self = [super init])
    {
        self._handler = handler;
        self._scriptController = [[LSCScriptController alloc] init];
    }
    
    return self;
}

- (void)run:(NSArray<LSCValue *> *)arguments
{
    if (self._handler)
    {
        [self._handler.context runThreadWithFunction:self._handler
                                           arguments:arguments
                                    scriptController:self._scriptController];
    }
}

- (void)exit
{
    [self._scriptController forceExit];
}

@end
