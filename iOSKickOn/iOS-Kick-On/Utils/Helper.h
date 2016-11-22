//
//  DataChecker.h
//  MicroSeller
//
//  Created by Mac on 15/5/12.
//  Copyright (c) 2015年 wjhgw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Helper : NSObject

+ (NSDictionary *)getTodayDate;

+ (BOOL) justEmail:(NSString *)email;
+ (BOOL) justMobile:(NSString *)mobile;
+ (BOOL) justUserName:(NSString *)name;
+ (BOOL) justPassword:(NSString *)passWord;
/// 添加虚线图
+ (UIImageView *)createImagenaryLineWithFrame:(CGRect)frame;
/// 给label添加删除线
+ (void)setStrikethroughInLabel:(UILabel *)label;
/// 给定位置的
+ (NSAttributedString *)setLabelAttributeString:(NSString*)labelText withCharactorSpace:(CGFloat)charactorSpace;
@end
