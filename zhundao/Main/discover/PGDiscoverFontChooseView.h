//
//  PGDiscoverFontChooseView.h
//  zhundao
//
//  Created by zhundao on 2017/9/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol fontsizeDelegate <NSObject>

- (void)postFontsize :(float)fontsize;

@end

@interface PGDiscoverFontChooseView : UIView
/*! 字体大小界面初始化 */
- (instancetype)initWithFrame:(CGRect)frame Fontsize :(float )fontsize;

@property(nonatomic,weak) id<fontsizeDelegate> fontsizeDelegate;

@property(nonatomic,assign)float fontsize;

@end
