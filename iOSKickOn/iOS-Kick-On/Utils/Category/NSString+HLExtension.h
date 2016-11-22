//
//  NSString+HLExtension.h
//  
//
//  Created by hanliu on 16/9/22.
//
//

#import <Foundation/Foundation.h>

@interface NSString (HLExtension)
- (BOOL)empty;
- (BOOL)notEmpty;
- (NSString *)md5;
- (NSString *)formatDate:(NSDate*)date;
- (NSString *)convertTimeStringToDateStringWithHMS:(BOOL)isNeedHMS;
@end
