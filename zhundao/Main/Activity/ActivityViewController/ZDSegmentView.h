//
//  ZDSegmentView.h
//  zhundao
//
//  Created by maj on 2019/5/26.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZDSegmentView;
@protocol ZDSegmentViewDelegate <NSObject>

- (void)segmentView:(nullable ZDSegmentView *)segmentView didSelectIndex:(NSInteger)index;

@end

@interface ZDSegmentView : UIView
@property (nonatomic, weak) id<ZDSegmentViewDelegate> segmentViewDelegate;

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray;

@property (nonatomic, strong) UIFont *textFont; // 字体
@property (nonatomic, assign) CGFloat lineWidth; //线的宽度
@property (nonatomic, assign) NSInteger currentIndex; // 当前页码
@property (nonatomic, assign) BOOL showBottomLine; // 是否显示底部黑线

@end

NS_ASSUME_NONNULL_END
