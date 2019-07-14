//
//  moreModalHeaderView.h
//  zhundao
//
//  Created by maj on 2018/11/30.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class moreModalHeaderView;

typedef NS_ENUM(NSInteger, chartType) {
    chartTypeApply,
    chartTypeBrowse,
    chartTypeIncome
};

@protocol moreModalHeaderViewDelegate <NSObject>
- (void)header:(moreModalHeaderView *)headerView didTapDetailView:(UIView *)detailView;
- (void)header:(moreModalHeaderView *)headerView didTapChartView:(chartType)type ;

@end

NS_ASSUME_NONNULL_BEGIN

@interface moreModalHeaderView : UICollectionReusableView

@property (nonatomic, strong) ActivityModel *model;
// 截止时间
@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, weak) id<moreModalHeaderViewDelegate> headerViewDelegate;

@end

NS_ASSUME_NONNULL_END
