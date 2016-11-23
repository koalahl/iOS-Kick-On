//
//  NSString+HLExtension.h
//  
//
//  Created by hanliu on 16/9/22.
//
//

#import <Foundation/Foundation.h>

@interface NSString (HLExtension)
- (BOOL) justEmail;
- (BOOL) justMobile;
- (BOOL) justUserName;
- (BOOL) justPassword;
- (BOOL)empty;
- (BOOL)notEmpty;
- (NSString *)md5;
- (NSString *)formatDate:(NSDate*)date;
- (NSString *)convertTimeStringToDateStringWithHMS:(BOOL)isNeedHMS;
@end
