//
//  ViewController.m
//  iOS-Kick-On
//
//  Created by HanLiu on 2016/11/22.
//  Copyright © 2016年 HanLiu. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+HLAdd.h"
#import "UIImageView+HLAdd.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView * v = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 240)];
    v.center = self.view.center;
    [self.view addSubview:v];
    
    
    UIImage * image = [UIImage imageNamed:@"IMG_0730"];
    
    //会产生混合图层
//    v.layer.cornerRadius = v.frame.size.width / 2;
//    v.layer.masksToBounds = YES;
//
//    //添加Corner分类后
//    [v setImage:[image hl_imageByCroppingForSize:CGSizeMake(240, 240) fillColor:[UIColor whiteColor]]];
    
    [image hl_imageByCroppingCorner:v.frame.size.width/2 forSize:v.frame.size completion:^(UIImage *image) {
       v.image = image;
    }];
    /*  使用Method swizzle交换setimage和hl_setImage:之后：
     *  如果要使用此方法，先去UIImageView+HLAdd的load方法中去掉注释：hl_swizzleSelector([self class], 
     *  @selector(setImage:), @selector(hl_setImage:));
     */
    //v.image = image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
