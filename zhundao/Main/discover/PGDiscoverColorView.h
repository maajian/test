//
//  PGDiscoverColorView.h
//  zhundao
//
//  Created by zhundao on 2017/9/22.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol colorDelegate <NSObject>

/*! 当前选择的rgb*/
- (void)colorViewCurrrentColor :(UIColor *)currentColor;

@end

@interface PGDiscoverColorView : UIView

@property(nonatomic,weak) id<colorDelegate> colorDelegate;
/*! 初始化方法 */
- (instancetype)initWithColor :(UIColor *)originColor;

@end
