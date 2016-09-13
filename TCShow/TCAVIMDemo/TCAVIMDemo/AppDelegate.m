//
//  AppDelegate.m
//  TCAVIMDemo
//
//  Created by AlexiChen on 16/5/16.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (instancetype)sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)enterMainUI
{
    if (!_liveHost)
    {
        // 用户修改默认主播角色， 主要是uid
        _liveHost = [[TCUser alloc] init];
        
        // 指定主播的ID
        _liveHost.uid = @"adev3";
        
        _liveHost.name = @"adev3";
        _liveHost.icon = nil;
        
        _liveRoom = [[TCAVRoom alloc] init];
        
        // 指定直播间的房间号，房间号记得不要与demo一致，防止其他人也使用了相同的房间号，导致直播出现异常
        _liveRoom.liveAVRoomId = 3312356;
        _liveRoom.liveHost = _liveHost;
        
        // 指定直播间的聊天室ID，可以不与liveAVRoomId相同
        _liveRoom.liveIMChatRoomId = @"3312356";
        
        _liveRoom.liveTitle = @"ywchen Live";
    }
    self.window.rootViewController = [[TarBarController alloc] init];
}

@end
