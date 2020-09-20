//
//  ZDSignInUpDataVC.h
//  zhundao
//
//  Created by zhundao on 2017/3/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDWebViewController.h"
typedef void(^successBlock) (BOOL issuccess);
@interface ZDSignInUpDataVC : ZDWebViewController
@property(nonatomic,copy)successBlock block;

@property (nonatomic, assign) BOOL isPresent;
@end
