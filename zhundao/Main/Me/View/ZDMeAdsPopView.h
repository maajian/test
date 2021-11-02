//
//  ZDMeAdsPopView.h
//  zhundao
//
//  Created by maj on 2021/9/23.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDMeAdsPopView : UIView
+ (void)showWithImage:(UIImage *)image clickBlock:(ZDBlock_Void)clickBlock cancelBlock:(ZDBlock_Void)cancelBlock;

@end

NS_ASSUME_NONNULL_END
