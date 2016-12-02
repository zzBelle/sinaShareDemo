//
//  FXShareSDKToo.h
//  YJQ-Patient
//
//  Created by 十月 on 16/8/2.
//  Copyright © 2016年 inf-technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"
@interface FXShareSDKToo : NSObject

@property (nonatomic, strong) void(^showMessageBlock)(NSString *);
/**
 *  初始化ShareSDK
 *
 */
+ (void)shareSDKToolRegisterApp;

/**
 *  分享功能
 *
 *  @param text   分享的正文内容
 *  @param images 分享的图片
 *  @param url    分享的链接字符串
 *  @param title  分享的标题
 *  @param type   SSDKContentType类型
 */
- (void)shareSDKToolWithText:(NSString *)text images:(NSArray *)images url:(NSString *)url title:(NSString *)title type:(SSDKContentType)type selectType:(SSDKPlatformType)selectType;


@end
