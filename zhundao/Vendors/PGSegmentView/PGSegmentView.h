//
//  PGSegmentView.h
//  zhundao
//
//  Created by maj on 2019/5/26.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PGSegmentView;
@protocol PGSegmentViewDelegate <NSObject>

- (void)segmentView:(nullable PGSegmentView *)segmentView didSelectIndex:(NSInteger)index;

@end

@interface PGSegmentView : UIView
@property (nonatomic, weak) id<PGSegmentViewDelegate> segmentViewDelegate;

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray;

@property (nonatomic, strong) UIFont *textFont; // 字体
@property (nonatomic, assign) CGFloat lineWidth; //线的宽度
@property (nonatomic, assign) NSInteger currentIndex; // 当前页码
@property (nonatomic, assign) BOOL showBottomLine; // 是否显示底部黑线

@end

NS_ASSUME_NONNULL_END
