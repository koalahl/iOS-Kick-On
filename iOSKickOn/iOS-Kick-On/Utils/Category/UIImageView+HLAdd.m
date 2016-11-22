//
//  UIImageView+HLAdd.m
//  iOS-Kick-On
//
//  Created by HanLiu on 2016/11/22.
//  Copyright © 2016年 HanLiu. All rights reserved.
//

#import "UIImageView+HLAdd.h"
#import "UIImage+HLAdd.h"
#import <objc/runtime.h>

static inline void hl_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

static inline BOOL hl_addMethod(Class theClass, SEL selector, Method method) {
    /*
    YES if the method was added successfully, otherwise NO (for example, the class already contains a method implementation with that name)
    */
    return class_addMethod(theClass, selector,  method_getImplementation(method),  method_getTypeEncoding(method));
}
@implementation UIImageView (HLAdd)
+ (void)load{
    NSLog(@"UIImageView class load");
    /* 这里参考的是AFURLSessionManager中的方式来添加方法，但是实际上在这个情况下是永远返回NO的。
     * 原因：因为我们是在UIImageView的category中添加了hl_setImage:，所以在UIImageView中已经存在了该方法，再调用class_addMethod就会返回NO。
     * 因此这句代码如果写在category中是不需要的了。
     */
    /*
     Method hlSetImageMethod = class_getInstanceMethod([self class],@selector(hl_setImage:));
     
     BOOL result = hl_addMethod([self class],@selector(hl_setImage:), hlSetImageMethod);
     NSLog(@"%d",result);
     if (result) {
     }
     */
    //hl_swizzleSelector([self class], @selector(setImage:), @selector(hl_setImage:));
}


- (void)hl_setImage:(UIImage *)image{
    //NSLog(@"%s   %@",__FUNCTION__,NSStringFromCGSize(self.bounds.size));
    
    image = [image hl_imageByCroppingForSize:self.bounds.size];
    
    //实际上这里是调用的系统的setImage的方法。因为已经交换了
    [self hl_setImage:image];
}
@end
