//
//  ZDAvtivityMoreModalHeaderView.h
//  zhundao
//
//  Created by maj on 2018/11/30.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDAvtivityMoreModalHeaderView;

typedef NS_ENUM(NSInteger, chartType) {
    chartTypeApply,
    chartTypeBrowse,
    chartTypeIncome
};

@protocol ZDAvtivityMoreModalHeaderViewDelegate <NSObject>
- (void)header:(ZDAvtivityMoreModalHeaderView *)headerView didTapDetailView:(UIView *)detailView;
- (void)header:(ZDAvtivityMoreModalHeaderView *)headerView didTapChartView:(chartType)type ;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ZDAvtivityMoreModalHeaderView : UICollectionReusableView

@property (nonatomic, strong) ActivityModel *model;
// 截止时间
@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, weak) id<ZDAvtivityMoreModalHeaderViewDelegate> headerViewDelegate;

@end

NS_ASSUME_NONNULL_END
