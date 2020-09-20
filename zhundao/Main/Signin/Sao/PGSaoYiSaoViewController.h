//
//  PGSaoYiSaoViewController.h
//  SaoYiSao
//
//  Created by ClaudeLi on 16/4/21.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGBaseVC.h"
#import <AVFoundation/AVFoundation.h>
typedef void(^countBlock)(NSInteger str);
@interface PGSaoYiSaoViewController :PGBaseVC <AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
- (void)otherView;
@property(nonatomic,assign)NSInteger signID;
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;
@property(nonatomic,copy)countBlock block;

@end
