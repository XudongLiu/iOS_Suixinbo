//
//  FullPreviewViewController.m
//  TCAVIMDemo
//
//  Created by AlexiChen on 16/7/5.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import "FullPreviewViewController.h"




@implementation FullFrameDispatcher

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
        [self onDeviceOrientationDidChange];
    }
    return self;
}

- (void)onDeviceOrientationDidChange
{
    UIInterfaceOrientation currentOri=(UIInterfaceOrientation)[[UIDevice currentDevice] orientation];
    switch (currentOri)
    {
        case UIDeviceOrientationPortrait:
            self.selfRotate = 1;
            break;
        case UIDeviceOrientationLandscapeLeft:
            self.selfRotate = 0;
            break;
        case UIDeviceOrientationLandscapeRight:
            self.selfRotate = 2;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            self.selfRotate = 3;
            break;
        default:
            break;
    }
}

- (void)dispatchVideoFrame:(QAVVideoFrame *)frame isLocal:(BOOL)isLocal isFront:(BOOL)frontCamera isFull:(BOOL)isFull
{
    NSString *renderKey = frame.identifier;
    
    AVGLRenderView *glView = [self.imageView getSubviewForKey:renderKey];
    
    if (glView)
    {
        unsigned int selfFrameAngle = 1;// [self didRotate:YES];
        unsigned int peerFrameAngle = frame.frameDesc.rotate % 4; //
        
        float degree;
        
        if (isLocal)
        {
            selfFrameAngle = 0;
            peerFrameAngle = 0;
            [glView setNeedMirrorReverse:frontCamera];
            degree = [self calcRotateAngle:peerFrameAngle selfAngle:selfFrameAngle];
        }
        else
        {
            
            
            if (frame.frameDesc.srcType == QAVVIDEO_SRC_TYPE_SCREEN)
            {
                // TODO:缺少测试源，暂不处理
                // frame.frameDesc.rotate = selfFrameAngle;
                degree = [self calcRotateAngle:peerFrameAngle selfAngle:selfFrameAngle];
            }
            else if (frame.frameDesc.srcType == QAVVIDEO_SRC_TYPE_CAMERA)
            {
                
                if (peerFrameAngle % 2 == 1)
                {
                    // 来源为竖屏
                    // do nothing
                    degree = [self calcRotateAngle:peerFrameAngle selfAngle:selfFrameAngle];
                }
                else
                {
                    // 来源为横屏
                    selfFrameAngle = self.selfRotate;
                    
                    if (selfFrameAngle % 2 == 0 && peerFrameAngle % 2 == 0)
                    {
                        degree = [self calcHorRotateAngle:peerFrameAngle selfAngle:selfFrameAngle];
                    }
                    else
                    {
                        frame.frameDesc.rotate = (selfFrameAngle + peerFrameAngle)%4;
                        peerFrameAngle = frame.frameDesc.rotate % 4;
                        degree = [self calcRotateAngle:peerFrameAngle selfAngle:selfFrameAngle];
                        
                    }
                }
                
            }
            else
            {
                degree = [self calcRotateAngle:peerFrameAngle selfAngle:selfFrameAngle];
            }
            
            [glView setNeedMirrorReverse:NO];
        }
        
        glView.isFloat = !isFull;
        
        AVGLImage * image = [[AVGLImage alloc] init];
        image.angle = isLocal ? degree + 180.0f : degree;
        image.data = (Byte *)frame.data;
        image.width = (int)frame.frameDesc.width;
        image.height = (int)frame.frameDesc.height;
        image.isFullScreenShow = [self calcFullScr:peerFrameAngle selfAngle:selfFrameAngle];
        image.viewStatus = VIDEO_VIEW_DRAWING;
        image.dataFormat = isLocal ?  Data_Format_NV12  : Data_Format_I420;
        
        [glView setImage:image];
    }
    
}

- (float)calcHorRotateAngle:(int)peerFrameAngle selfAngle:(int)frameAngle
{
    float degree = 0.0f;
    
    // 调整显示角度
    switch (peerFrameAngle)
    {
        case 0:
        {
            // Left
            if (frameAngle == 0)
            {
                degree = -90.0f;
                return degree;
            }
            else if (frameAngle == 2)
            {
                degree = 90.0f;
                return degree;
            }
        }
            break;
            
        case 2:
        {
            // Left
            if (frameAngle == 0)
            {
                degree = 90.0f;
                return degree;
            }
            else if (frameAngle == 2)
            {
                degree = -90.0f;
                return degree;
            }
        }
            break;
            
        default:
        {
            degree = 0.0f;
        }
            break;
    }
    
    return [self calcRotateAngle:peerFrameAngle selfAngle:frameAngle];
}





@end



@implementation FullLivePreview

- (void)configDispatcher
{
    if (!_frameDispatcher)
    {
        _frameDispatcher = [[FullFrameDispatcher alloc] init];
        _frameDispatcher.imageView = _imageView;
    }
    else
    {
        DebugLog(@"Protected方法，外部禁止调用");
    }
}

@end

@interface FullPreviewViewController ()

@end

@implementation FullPreviewViewController

- (void)addLiveView
{
    // 子类重写
    UserAppBaseUIViewController *uivc = [[UserAppBaseUIViewController alloc] initWith:self];
    [self addChild:uivc inRect:self.view.bounds];
    
    _liveView = uivc;
}

- (void)addLivePreview
{
    _livePreview = [[FullLivePreview alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_livePreview];
    [_livePreview registLeaveView:[TCAVLeaveView class]];
    
    [_livePreview addRenderFor:[_roomInfo liveHost]];
}

@end
