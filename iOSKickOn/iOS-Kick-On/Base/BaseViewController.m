//
//  BaseViewController.m
//  WMALL
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 wjhg. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworkReachabilityManager.h"

@interface BaseViewController ()

@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation BaseViewController

- (UIViewController *)lastViewController {
    NSArray *controllers = self.navigationController.viewControllers;
    NSInteger index = controllers.count - 2;
    if (index < 0) {
        return nil;
    }
    return controllers[index];
}

+ (instancetype)newInstance {
    BaseViewController *instance = nil;
    NSString *className = NSStringFromClass([self class]);
    NSURL *url = [[NSBundle mainBundle] URLForResource:className withExtension:@"nib"];
    if (url) {
        instance = [[self class] newInstanceWithNibName:className];
    } else {
        instance = [[[self class] alloc] init];
    }
    return instance;
}

+ (instancetype)newInstanceWithNibName:(NSString *)nibName {
    return [[[self class] alloc] initWithNibName:nibName bundle:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(242, 242, 242);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkReachabilityStatusDidChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    /*
    if
    if (self.navigationController.viewControllers && self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"nav_back_icon") style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButton_touch:)];
        [back setTintColor:RGB_HEX(0x999999)];
        self.navigationItem.leftBarButtonItem = back;
    }
    */
    _hud = [[MBProgressHUD alloc] init];
}
- (void)networkReachabilityStatusDidChange:(NSNotification *)notify{
    NSLog(@"网络变化通知：%@",notify.userInfo[AFNetworkingReachabilityNotificationStatusItem]);
    AFNetworkReachabilityStatus status = [notify.userInfo[AFNetworkingReachabilityNotificationStatusItem] integerValue];
    NSString *net = nil;
    switch (status) {
        case AFNetworkReachabilityStatusNotReachable:
            net = @"无网络";
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            net = @"WIFI";
            [self changeUserAgentWithType:@"WIFI"];
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            net = @"2G/3G/4G";
            [self changeUserAgentWithType:@"3G"];
            break;
        default:
            net = @"xxx";
            break;
    }
    //[WMNotification showError:[NSString stringWithFormat:@"当前网络状态%@",net]];
}
- (void)changeUserAgentWithType:(NSString *)type{
    NSMutableString *userAgent = [NSMutableString stringWithString:[[UIWebView new] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]];
    NSString *newUagent = nil;
    NSString *temp = nil;
    if ([userAgent containsString:@"NetType"]) {
        if ([userAgent containsString:@"WIFI"]) {
            temp = @"WIFI";
        }else if([userAgent containsString:@"3G"]){
            temp = @"3G";
        }
        newUagent = [userAgent stringByReplacingOccurrencesOfString:temp withString:type];

    }else{
        newUagent = [NSString stringWithFormat:@"%@ NetType/%@", userAgent, type];
    }
 
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newUagent, @"UserAgent", nil];
    
    NSLog(@"new useragent:%@",newUagent);
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unloginNotification:) name:NOTIFICATION_UNLOGIN object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)unloginNotification:(NSNotification *)notification {
 
    //登录相关的通知
 
    if (![notification.userInfo[@"api"] isEqual:API_Logout]) {
        [TOKEN clearToken];
        [self showLogin];
        [MainTabBarController selectHome];
        [[LoginViewController sharedInstance] showTips:@"请重新登陆" delay:2.0];
    }
}
*/
- (void)leftBarButton_touch:(id)sender {
    [self back];
}

- (UIAlertView *)alert:(NSString *)message {
    return [self alert:@"温馨提示" message:message];
}

- (UIAlertView *)alert:(NSString *)title message:(NSString *)message {
    return [self alert:title message:message cancelButtonTitle:@"好的"];
}

- (UIAlertView *)alert:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle {
    return [self alert:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitle:nil];
}

- (UIAlertView *)alert:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)first, ... {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    va_list args;
    va_start(args, first);
    for (NSString * value = first; value != nil; value = va_arg(args, NSString *)) {
        [alert addButtonWithTitle:value];
    }
    va_end(args);
    [alert show];
    return alert;
}

- (MBProgressHUD *)showTips:(NSString *)title {
    MBProgressHUD *tips = [self showTips:title delay:1];
    return tips;
}

- (MBProgressHUD *)showTips:(NSString *)title delay:(NSTimeInterval)afterDelay {
    MBProgressHUD *tips = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    tips.mode = MBProgressHUDModeText;
    tips.detailsLabelFont = [UIFont boldSystemFontOfSize:13.0];
    tips.removeFromSuperViewOnHide = YES;
    if (title) {
        tips.detailsLabelText = title;
    }
    [tips hide:YES afterDelay:afterDelay];
    return tips;
}

- (MBProgressHUD *)showHUD {
    return [self showHUD:@"正在加载"];
}

- (MBProgressHUD *)showHUD:(NSString *)title {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (title) {
        self.hud.label.text = title;
        self.hud.label.font = [UIFont systemFontOfSize:13];
    }
    return _hud;
}

- (MBProgressHUD *)showHUD:(NSString *)title delay:(NSTimeInterval)afterDelay {
    [self showHUD:title];
    [self hideHUD:afterDelay];
    return _hud;
}

- (void)hideHUD {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)hideHUD:(NSTimeInterval)afterDelay {
    [self.hud hideAnimated:YES afterDelay:afterDelay];
}

- (void)back {
    if (self.navigationController.viewControllers && self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//- (void)showLogin {
//    if ([self isKindOfClass:[LoginViewController class]]) {
//        return;
//    }
//    LoginViewController *logVC = [LoginViewController sharedInstance];
//    [logVC setShowCancel:YES];
//    if (![LoginService isLogin] && !logVC.isShown) {
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:logVC] animated:YES completion:nil];
//        logVC.shown = YES;
//    }
//}

-(BOOL)gestureRecognizerShouldBegin{

    return YES;
}

@end
