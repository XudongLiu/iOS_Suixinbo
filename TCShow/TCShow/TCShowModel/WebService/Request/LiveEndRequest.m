//
//  LiveEndRequest.m
//  TCShow
//
//  Created by AlexiChen on 16/4/27.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import "LiveEndRequest.h"

@implementation LiveEndRequest

- (NSString *)url
{
    return @"http://zb.fingeroffice.cn/index.php?svc=live&cmd=end";
}


- (NSDictionary *)packageParams
{
    return [_liveItem toHeartBeatJson];
}

- (Class)responseDataClass
{
    return [LiveEndResponseData class];
}

@end

@implementation LiveEndResponseData



@end
