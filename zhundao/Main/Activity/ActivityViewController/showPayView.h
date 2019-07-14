//
//  showPayView.h
//  zhundao
//
//  Created by zhundao on 2017/11/8.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol showPayViewDelegate <NSObject>

- (void)verify:(NSString *)password;

@end

@interface showPayView : UIView
/*! 初始化 */
- (instancetype)initWithMoney:(CGFloat)money;

@property(nonatomic,weak) id<showPayViewDelegate> showPayViewDelegate;

@end
