//
//  PGMePromoteBottomView.h
//  zhundao
//
//  Created by maj on 2020/1/17.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PGMePromoteBottomView;
@protocol PGMePromoteBottomViewDelegate <NSObject>
- (void)promoteBottomView:(PGMePromoteBottomView *)promoteBottomView didSelectMainButton:(UIButton *)button;
- (void)promoteBottomView:(PGMePromoteBottomView *)promoteBottomView didSelectShareButton:(UIButton *)button;

@end

@interface PGMePromoteBottomView : UIView

@property (nonatomic, weak) id<PGMePromoteBottomViewDelegate> promoteBottomViewDelegate;

@property (nonatomic, assign) NSInteger currentIndex;
- (void)refreshLayout;

@end

NS_ASSUME_NONNULL_END
