//
//  AppDelegate+ALiPay.h
//  hongmeng
//
//  Created by lian on 16/9/6.
//  Copyright © 2016年 lian. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (ALiPay)
+ (void)AliPayClicked:(NSString*)productNO price:(float)productPrice callBack:(void(^)( NSDictionary *resultDic))re;
- (BOOL)applicationForAliPay:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;
@end
