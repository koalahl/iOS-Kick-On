//
//  AppDelegate+ALiPay.m
//  hongmeng
//
//  Created by Han Liu on 16/9/6.
//  Copyright © 2016年 lian. All rights reserved.
//

#import "AppDelegate+ALiPay.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "DataVerifier.h"
#import "AlipayConfig.h"

id retunObjectForKey(id aKey ,NSDictionary *dict)
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@implementation AppDelegate (ALiPay)
- (BOOL)applicationForAliPay:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if([retunObjectForKey(@"resultStatus", resultDic) intValue]==9000){

            NSNotification *notification =[NSNotification notificationWithName:@"paySuccess" object:nil userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
        }];
    }
    return YES;
}

+ (void)AliPayClicked:(NSString*)productNO price:(float)productPrice callBack:(void(^)( NSDictionary *resultDic))re
{
    
    /*
     *点击获取prodcut实例并初始化订单信息
     */
//    Product *product = [productList objectAtIndex:0];
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = Partner;
    NSString *seller = Seller;
    NSString *privateKey = PrivateKey;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    // NOTE: app_id设置
    order.appID = @"2016101802231601";
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = productNO; //订单ID（由商家自行制定）
    order.subject = productNO; //商品标题
    order.body = productNO; //商品描述
    order.totalFee = [NSString stringWithFormat:@"%.2f",productPrice]; //商品价格
    order.notifyURL =  ALiUrl; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"com.hongmeng";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            if(re)re(resultDic);
        }];
    }
    
}

@end
