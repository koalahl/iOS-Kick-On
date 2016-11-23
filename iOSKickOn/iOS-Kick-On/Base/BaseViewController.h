//
//  BaseViewController.h
//  WMALL
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 wjhg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UIAlertViewDelegate, MBProgressHUDDelegate>

@property (weak, nonatomic, readonly) UIViewController *lastViewController;

+ (instancetype)newInstance;
+ (instancetype)newInstanceWithNibName:(NSString *)nibName;

- (UIAlertView *)alert:(NSString *)message;
- (UIAlertView *)alert:(NSString *)title message:(NSString *)message;
- (UIAlertView *)alert:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;
- (UIAlertView *)alert:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)first, ... NS_REQUIRES_NIL_TERMINATION;

- (MBProgressHUD *)showTips:(NSString *)title;
- (MBProgressHUD *)showTips:(NSString *)title delay:(NSTimeInterval)afterDelay;

- (MBProgressHUD *)showHUD;
- (MBProgressHUD *)showHUD:(NSString *)title;
- (MBProgressHUD *)showHUD:(NSString *)title delay:(NSTimeInterval)afterDelay;
- (void)hideHUD;
- (void)hideHUD:(NSTimeInterval)afterDelay;

- (void)back;

//- (void)showLogin;

-(BOOL)gestureRecognizerShouldBegin;

@end
