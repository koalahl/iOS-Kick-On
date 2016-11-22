//
//  UIImage+HLAdd.h
//  iOS-Kick-On
//
//  Created by HanLiu on 2016/11/22.
//  Copyright © 2016年 HanLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Corner)

- (void)hl_imageByCroppingCorner:(CGFloat)radius forSize:(CGSize)targetSize completion:(void(^)(UIImage *))completion;

- (UIImage*)hl_imageByCroppingForSize:(CGSize)targetSize;

- (UIImage*)hl_imageByCroppingCorner:(CGFloat)radius forSize:(CGSize)targetSize fillColor:(UIColor *)fillColor;

- (UIImage*)hl_imageByCroppingForSize:(CGSize)targetSize fillColor:(UIColor *)fillColor;
@end
