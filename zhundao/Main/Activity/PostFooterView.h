//
//  PostFooterView.h
//  zhundao
//
//  Created by zhundao on 2017/9/13.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol footerDelegate <NSObject>

- (void)pushToXieyi;

- (void)post;

@end

@interface PostFooterView : UIView

@property(nonatomic,weak) id<footerDelegate> footerDelegate;

@end
