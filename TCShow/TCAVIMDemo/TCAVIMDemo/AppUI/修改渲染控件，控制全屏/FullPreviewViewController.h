//
//  FullPreviewViewController.h
//  TCAVIMDemo
//
//  Created by AlexiChen on 16/7/5.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import "TCAVLiveViewController.h"

// 因各业务端的需求不一样，此处只提供例子
// 业务方自行根据代码进行调试出自己要的效果

@interface FullFrameDispatcher : TCAVFrameDispatcher
@property (nonatomic, assign) unsigned int selfRotate;
@end

@interface FullLivePreview : TCAVLivePreview

@end

@interface FullPreviewViewController : TCAVLiveViewController

@end
