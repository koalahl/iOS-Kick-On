//
//  NSString+HLExtension.m
//  
//
//  Created by hanliu on 16/9/22.
//
//

#import "NSString+HLExtension.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Extension)
- (BOOL) justEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
- (BOOL) justMobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
- (BOOL) justUserName{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:self];
    return B;
}
- (BOOL) justPassword{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}
- (BOOL)empty {
    return !self || ![self notEmpty];
}

- (BOOL)notEmpty {
    return self && self.length;
}

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)formatDate:(NSDate*)date{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}
- (NSString *)convertTimeStringToDateStringWithHMS:(BOOL)isNeedHMS{
    NSTimeInterval interval      = [self doubleValue];
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

@end
