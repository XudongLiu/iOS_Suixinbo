//
//  AppDelegate.m
//  TCSoLive
//
//  Created by wilderliao on 16/7/15.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (instancetype)sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

// 配置App中的控件的默认属性
- (void)configAppearance
{
}

//登录成功后会自动调用enterMainUI
- (void)enterMainUI
{
    if (!_liveHost)
    {
        // 用户修改默认主播角色， 主要是uid
        _liveHost = [[TCUser alloc] init];
        
        _liveRoom = [[TCAVRoom alloc] init];
        
        _liveRoom.liveHost = _liveHost;
    }
    MainViewController *vc = [[MainViewController alloc] init];
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
}


@end
