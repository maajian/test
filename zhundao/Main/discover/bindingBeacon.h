//
//  SaoYiSaoViewController.h
//  SaoYiSao
//
//  Created by ClaudeLi on 16/4/21.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SaoYiSaoViewController.h"
typedef void(^block) (BOOL issuccess);
@interface bindingBeacon : SaoYiSaoViewController<AVCaptureMetadataOutputObjectsDelegate>
{
  
}
@property(nonatomic,copy)block backblock;

@end
