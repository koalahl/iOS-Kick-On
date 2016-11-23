//
//  AppConfig.h
//  hongmeng
//
//  Created by hanliu on 16/9/22.
//  Copyright © 2016年 lian. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h


#pragma mark - #pragma mark -  callService

#define NavigationBar_HEIGHT 44     //导航控制器

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)      //屏幕宽度

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)    //屏幕高度

#define PIXEL(number)                   (number / [UIScreen mainScreen].scale)

#define RGBFloatCOLOR(r,g,b) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:1.000]  

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.000]  //设置颜色

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// rgb颜色转换（16进制->10进制）
#define HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]


#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#pragma mark - 系统 部分

//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//#define IS_IPHONE ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])

//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//#define IS_IPAD ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"])

//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f

// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f

// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f

//获取系统版本
//这个方法不是特别靠谱
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//建议使用这个方法
#define IOS_SYSTEM_STRING [[UIDevice currentDevice] systemVersion]

//判断 iOS 8 或更高的系统版本
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))
#define IOS_VERSION_10_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=10.0)? (YES):(NO))

#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])   //当前的设备的默认语言

#define isRetina ([[UIScreen mainScreen] scale]== 2 ? YES : NO)    //是否是高清屏

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)    //是否是IPhone5

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) //是否是IPAD


#pragma mark - Block
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


#pragma mark - 图片，返回UIImage
#define LoadCacheImage(name) [UIImage imageNamed:name]
#define LoadDiskImage(name)  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]]


#define USER_DEFAULT [NSUserDefaults standardUserDefaults]      //UserDefault


#define degreesToRadian(x) (M_PI * (x) / 180.0) //弧度转角度

#define radianToDegrees(radian) (radian*180.0)/(M_PI)  //角度转弧度


#pragma mark - Path
#define kHomePath        NSHomeDirectory()
#define kCachePath      [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]
#define kDocumentFolder [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kDocumentFolder2 [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define kLibraryPath [NSHomeDirectory() stringByAppendingPathComponent:@"Library"]
#define kTempPath    NSTemporaryDirectory()
#define kMainBoundPath [[NSBundle mainBundle] bundlePath]
#define kResourcePath  [[NSBundle mainBundle] resourcePath]
#define kExecutablePath [[NSBundle mainBundle] executablePath]


#pragma mark - Setting
//当前系统设置国家的country iso code
#define countryISO  [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode]
//当前系统设置语言的iso code
#define languageISO [[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode]



#define CountryNameFromISO(iso) CountryNameByISO(iso)



#pragma mark - 单例
#define DeclareSingletonInterface(className)  \
+ (classname *)shared##classname

#define ImplementSingletonInterface(className) \
+ (classname *)shared##classname { \
static dispatch_once_t onceToken = 0; \
static id sharedInstance = nil; \
dispatch_once(&onceToken, ^{ \
sharedInstance = [[self alloc] init]; \
}); \
return sharedInstance; \
}

#pragma mark - 功能部分

#ifdef DEBUG
#define NSLog(args,...) NSLog(@"-%d%s:%@",__LINE__,__FUNCTION__,[NSString stringWithFormat:(args), ##__VA_ARGS__])
#else
#define NSLog(...)
#endif

#ifdef DEBUG
#   define DLog(...) NSLog((@"%s [Line %d] %@"), __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#   define SLog(...) NSLog(__VA_ARGS__)
#else
#   define DLog(...)
#   define SLog(...)
#endif
//SLog(kMainBoundPath, nil);

//针对真机iPhone
#if TARGET_OS_IPHONE
//iPhone Device
#endif

//针对模拟器
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

#endif /* AppConfig_h */
