//
//  ZDDiscoverShowView.h
//  zhundao
//
//  Created by zhundao on 2017/9/14.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^addInviteBlock)(NSString *inviteTitle);

@interface ZDDiscoverShowView : UIView

- (void)fadeIn;

- (instancetype)initWithImage:(UIImage *)image1 name:(NSString *)name;

@property(nonatomic,copy)addInviteBlock addInviteBlock;

@end
