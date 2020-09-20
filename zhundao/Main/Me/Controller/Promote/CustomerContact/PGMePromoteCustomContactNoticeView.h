//
//  PGMePromoteCustomContactNoticeView.h
//  zhundao
//
//  Created by maj on 2020/1/8.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PGMePromoteNoticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@class PGMePromoteCustomContactNoticeView;
@protocol PGMePromoteCustomContactNoticeViewDelegate <NSObject>
// 点击更多
- (void)promoteCustomContactNoticeView:(PGMePromoteCustomContactNoticeView *)promoteCustomContactNoticeView didTapMoreButton:(UIButton *)button;
// 公告
- (void)promoteCustomContactNoticeView:(PGMePromoteCustomContactNoticeView *)promoteCustomContactNoticeView didTapNotice:(PGMePromoteNoticeModel *)model;

@end

@interface PGMePromoteCustomContactNoticeView : UIView

@property (nonatomic, weak) id<PGMePromoteCustomContactNoticeViewDelegate> promoteCustomContactNoticeViewDelegate;

@property (nonatomic, strong) NSMutableArray <PGMePromoteNoticeModel *> *noticeArray;

@end

NS_ASSUME_NONNULL_END
