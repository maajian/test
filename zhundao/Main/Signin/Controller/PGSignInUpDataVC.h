//
//  PGSignInUpDataVC.h
//  zhundao
//
//  Created by zhundao on 2017/3/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGWebViewController.h"
typedef void(^successBlock) (BOOL issuccess);
@interface PGSignInUpDataVC : PGWebViewController
@property(nonatomic,copy)successBlock block;

@property (nonatomic, assign) BOOL isPresent;
@end
