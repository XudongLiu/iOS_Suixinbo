//
//  LiveStartRequest.m
//  TCShow
//
//  Created by AlexiChen on 16/4/27.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import "LiveStartRequest.h"

@implementation LiveStartRequest

- (NSString *)url
{
    return @"http://zb.fingeroffice.cn/index.php?svc=live&cmd=start";
    
}

- (NSDictionary *)packageParams
{
    return [_liveItem toLiveStartJson];
}

@end
