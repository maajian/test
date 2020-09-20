//
//  ZDMeMyMessageView.h
//  zhundao
//
//  Created by zhundao on 2017/11/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDMeMyMessageViewDelegate <NSObject>

/*! 常用问题 */
- (void)allQues;
/*! 充值短信 */
- (void)payMessage;
/*! 返回 */
- (void)backpop;



@end

@interface ZDMeMyMessageView : UIScrollView
/*! 剩余短信label */
@property(nonatomic,strong)UILabel *countLabel;

@property(nonatomic,weak) id<ZDMeMyMessageViewDelegate> ZDMeMyMessageViewDelegate;



@end
