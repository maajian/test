//
//  ZDActivityPostSignView.h
//  zhundao
//
//  Created by maj on 2021/5/12.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZDSignInModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ZDActivityPostSignView;
@protocol ZDActivityPostSignViewDelegate <NSObject>

- (void)postSignView:(ZDActivityPostSignView *)postSignView didChooseType:(NSInteger)type name:(NSString *)name;
 
@end

@interface ZDActivityPostSignView : UIView
@property (nonatomic, weak) id<ZDActivityPostSignViewDelegate> postSignViewDelegate;
- (instancetype)initWithModel:(ZDSignInModel *)model activityName:(NSString *)activityName;

@end

NS_ASSUME_NONNULL_END
