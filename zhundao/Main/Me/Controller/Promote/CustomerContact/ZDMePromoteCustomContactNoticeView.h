//
//  ZDMePromoteCustomContactNoticeView.h
//  zhundao
//
//  Created by maj on 2020/1/8.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZDMePromoteNoticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ZDMePromoteCustomContactNoticeView;
@protocol ZDMePromoteCustomContactNoticeViewDelegate <NSObject>
// 点击更多
- (void)promoteCustomContactNoticeView:(ZDMePromoteCustomContactNoticeView *)promoteCustomContactNoticeView didTapMoreButton:(UIButton *)button;
// 公告
- (void)promoteCustomContactNoticeView:(ZDMePromoteCustomContactNoticeView *)promoteCustomContactNoticeView didTapNotice:(ZDMePromoteNoticeModel *)model;

@end

@interface ZDMePromoteCustomContactNoticeView : UIView

@property (nonatomic, weak) id<ZDMePromoteCustomContactNoticeViewDelegate> promoteCustomContactNoticeViewDelegate;

@property (nonatomic, strong) NSMutableArray <ZDMePromoteNoticeModel *> *noticeArray;

@end

NS_ASSUME_NONNULL_END
