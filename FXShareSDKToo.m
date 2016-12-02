//
//  FXShareSDKToo.m
//  YJQ-Patient
//
//  Created by 十月 on 16/8/2.
//  Copyright © 2016年 inf-technology. All rights reserved.
//

#import "FXShareSDKToo.h"
#import "AppDelegate.h"
@interface FXShareSDKToo () <WXApiDelegate>

@end

@implementation FXShareSDKToo
//de4e40003e8f  c5298ee5ee38
+ (void)shareSDKToolRegisterApp {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    [ShareSDK registerApp: @"c5298ee5ee38" activePlatforms:@[@(SSDKPlatformSubTypeWechatSession),
                                                             @(SSDKPlatformSubTypeWechatTimeline),
                                                             @(SSDKPlatformTypeSinaWeibo)] onImport:^(SSDKPlatformType platformType) {
                                                                 
                                                                 switch (platformType) {
                                                                     case SSDKPlatformTypeWechat:
                                                                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:delegate];
                                                                         break;
                                                                     case SSDKPlatformTypeSinaWeibo:
                                                                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                                                         default:
                                                                             break;
                                                                     }
                                                                     
                                                                 } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                                                     switch (platformType) {
                                                                             
                                                                         case SSDKPlatformTypeWechat:
                                                                             [appInfo
                                                                              SSDKSetupWeChatByAppId:WEIXIN_APP_KEY appSecret:WEIXIN_APP_SECRET];
                                                                             break;
                                                                         
                                                                         case SSDKPlatformTypeSinaWeibo:
                                                                             [appInfo SSDKSetupSinaWeiboByAppKey:SINA_APP_KEY appSecret:SINA_APP_SECRET redirectUri:SINA_APP_REDIRECTURL authType:SSDKAuthTypeWeb];
                                                                             
                                                                             break;
                                                                         default:
                                                                             break;
                                                                     }
                                                                 }];
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    
    NSLog(@"The response of wechat.");
}

- (void)shareSDKToolWithText:(NSString *)text images:(NSArray *)images url:(NSString *)url title:(NSString *)title type:(SSDKContentType)type selectType:(SSDKPlatformType)selectType {
    
    if (images) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        
        [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@%@",text,url]
                                         images:images
                                            url:[NSURL URLWithString:url]
                                          title:title
                                           type:type];
        
        [shareParams SSDKEnableUseClientShare];
        //进行分享
        [ShareSDK share:selectType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            switch (state){
                case SSDKResponseStateSuccess:
                    NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功!"));
                    self.showMessageBlock(@"分享成功");
                    break;
                case SSDKResponseStateFail:
                    self.showMessageBlock(@"分享失败");
                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", state, error);
                    NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), state, error);
                    break;
                    
                default:
                    break;
            }

      }];
    }
}
@end
