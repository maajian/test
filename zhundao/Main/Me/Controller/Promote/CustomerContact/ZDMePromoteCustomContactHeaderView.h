//
//  ZDDiscoverPromoteCustomContactHeaderView.h
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZDMePromoteNoticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ZDMePromoteCustomContactHeaderView;
@protocol ZDMePromoteCustomContactHeaderViewDelegate <NSObject>
- (void)promoteCustomContactHeaderView:(ZDMePromoteCustomContactHeaderView *)promoteCustomContactHeaderView didTapExtendButton:(UIButton *)button;
- (void)promoteCustomContactHeaderView:(ZDMePromoteCustomContactHeaderView *)promoteCustomContactHeaderView didTapMoreButton:(UIButton *)button;
- (void)promoteCustomContactHeaderView:(ZDMePromoteCustomContactHeaderView *)promoteCustomContactHeaderView didTapNotice:(ZDMePromoteNoticeModel *)model;

@end

@interface ZDMePromoteCustomContactHeaderView : UIView
@property (nonatomic, assign) NSInteger zhundaoBi;
@property (nonatomic, strong) NSMutableArray <ZDMePromoteNoticeModel *> *noticeArray;
@property (nonatomic, assign) id<ZDMePromoteCustomContactHeaderViewDelegate> promoteCustomContactHeaderViewDelegate;

@end

NS_ASSUME_NONNULL_END
