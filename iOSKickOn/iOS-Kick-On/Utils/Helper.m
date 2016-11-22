//
//  DataChecker.m
//  MicroSeller
//
//  Created by Mac on 15/5/12.
//  Copyright (c) 2015年 wjhgw. All rights reserved.
//

#import "Helper.h"
#import <CoreText/CoreText.h>

@implementation Helper

//获取今天的日期
+ (NSDictionary *)getTodayDate
{
    
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay;
    
    NSDateComponents *components = [calendar components:unit fromDate:today];
    NSString *year = [NSString stringWithFormat:@"%ld", (long)[components year]];
    NSString *month = [NSString stringWithFormat:@"%02ld", (long)[components month]];
    NSString *day = [NSString stringWithFormat:@"%02ld", (long)[components day]];
    
    NSMutableDictionary *todayDic = [[NSMutableDictionary alloc] init];
    [todayDic setObject:year forKey:@"year"];
    [todayDic setObject:month forKey:@"month"];
    [todayDic setObject:day forKey:@"day"];
    
    return todayDic;
    
}

+ (NSString *)convertTimeStringToDate:(NSString *)timeString withHMS:(BOOL)isNeedHMS{
    NSTimeInterval interval      = [timeString doubleValue];
    NSDate * date                = [NSDate dateWithTimeIntervalSince1970:interval];

    NSCalendar *calendar         = [NSCalendar currentCalendar];
    NSCalendarUnit unit          = kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay |kCFCalendarUnitHour |kCFCalendarUnitMinute |kCFCalendarUnitSecond;

    NSDateComponents *components = [calendar components:unit fromDate:date];
    NSString *year               = [NSString stringWithFormat:@"%ld", (long)[components year]];
    NSString *month              = [NSString stringWithFormat:@"%02ld", (long)[components month]];
    NSString *day                = [NSString stringWithFormat:@"%02ld", (long)[components day]];
    NSString *hour               = [NSString stringWithFormat:@"%02ld",(long)[components hour]];
    NSString *min                = [NSString stringWithFormat:@"%02ld",(long)[components minute]];
    NSString *sec                = [NSString stringWithFormat:@"%02ld",(long)[components second]];
    if (isNeedHMS) {
        return [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",year,month,day,hour,min,sec];
    }
    return [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
}

//邮箱
+ (BOOL) justEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL) justMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:mobile];
}


//用户名
+ (BOOL) justUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL) justPassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

+ (UIImageView *)createImagenaryLineWithFrame:(CGRect)frame{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    CGFloat lengths[] = {2,2};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor lightGrayColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 10, 0.0);    //开始画线
    CGContextAddLineToPoint(line, [UIScreen mainScreen].bounds.size.width-10, 0.0);
    CGContextStrokePath(line);
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    return imageView;
}

+ (NSAttributedString *)setLabelAttributeString:(NSString*)labelText withCharactorSpace:(CGFloat)charactorSpace{
    NSMutableAttributedString *string =[[NSMutableAttributedString alloc]initWithString:labelText];
    long number = charactorSpace;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [string addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[string length])];
    CFRelease(num);
    return string;
}

+ (void)setStrikethroughInLabel:(UILabel *)label{
    NSInteger length = [[label text] length];
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc]initWithString:label.text ];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle | NSUnderlinePatternSolid) range:NSMakeRange(0, length)];
    [label setAttributedText:attributeString];
}
@end
