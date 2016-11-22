//
//  UIImage+HLAdd.m
//  iOS-Kick-On
//
//  Created by HanLiu on 2016/11/22.
//  Copyright © 2016年 HanLiu. All rights reserved.
//

#import "UIImage+HLAdd.h"

@implementation UIImage (HLAdd)

- (void)hl_imageByCroppingCorner:(CGFloat)radius forSize:(CGSize)targetSize completion:(void(^)(UIImage *))completion{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage * result = [self hl_imageByCroppingCorner:radius forSize:targetSize fillColor:[UIColor whiteColor]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(result);
            }
        });
    });
}
- (UIImage*)hl_imageByCroppingForSize:(CGSize)targetSize{
    return [self hl_imageByCroppingForSize:targetSize fillColor:[UIColor whiteColor]];
}

- (UIImage*)hl_imageByCroppingForSize:(CGSize)targetSize fillColor:(UIColor *)fillColor{

    return [self hl_imageByCroppingCorner:targetSize.width/2 forSize:targetSize fillColor:fillColor];
}


- (UIImage*)hl_imageByCroppingCorner:(CGFloat)radius forSize:(CGSize)targetSize fillColor:(UIColor *)fillColor{

    CFTimeInterval start = CACurrentMediaTime();
    //获取屏幕拉伸比例
    CGFloat  scale = [UIScreen mainScreen].scale;
    
    //创建上下文
    UIGraphicsBeginImageContextWithOptions(targetSize, YES, scale);
    
    //利用贝塞尔曲线构造圆形路径
    CGRect rect = CGRectMake(0, 0, targetSize.width, targetSize.height);
    //设置填充颜色
    [fillColor setFill];
    
    //需要放在裁剪方法之前才生效
    UIRectFill(rect);
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    //裁剪方法
    [path addClip];
    
    //重绘
    [self drawInRect:rect];
    //获取结果
    UIImage * result = UIGraphicsGetImageFromCurrentImageContext();
    //关闭
    UIGraphicsEndImageContext();
    
    NSLog(@"%f",CACurrentMediaTime() - start);
    return result;
    
    
}

@end
