//
//  ZDMePromoteBottomView.h
//  zhundao
//
//  Created by maj on 2020/1/17.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZDMePromoteBottomView;
@protocol ZDMePromoteBottomViewDelegate <NSObject>
- (void)promoteBottomView:(ZDMePromoteBottomView *)promoteBottomView didSelectMainButton:(UIButton *)button;
- (void)promoteBottomView:(ZDMePromoteBottomView *)promoteBottomView didSelectShareButton:(UIButton *)button;

@end

@interface ZDMePromoteBottomView : UIView

@property (nonatomic, weak) id<ZDMePromoteBottomViewDelegate> promoteBottomViewDelegate;

@property (nonatomic, assign) NSInteger currentIndex;
- (void)refreshLayout;

@end

NS_ASSUME_NONNULL_END
