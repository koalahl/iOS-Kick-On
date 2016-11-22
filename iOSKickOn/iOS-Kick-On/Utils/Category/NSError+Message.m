//
//  NSError+Message.m
//  WMALL
//
//  Created by HanLiu on 15/12/1.
//  Copyright © 2015年 wjhg. All rights reserved.
//

#import "NSError+Message.h"
#import <objc/runtime.h>

static void * strKey = &strKey;

@implementation NSError (Message)

- (void)setErrorMsg:(NSString *)errorMsg{
    objc_setAssociatedObject(self, & strKey, errorMsg, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)errorMsg{
    return objc_getAssociatedObject(self, &strKey);
}

@end
