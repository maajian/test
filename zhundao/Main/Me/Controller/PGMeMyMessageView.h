//
//  PGMeMyMessageView.h
//  zhundao
//
//  Created by zhundao on 2017/11/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PGMeMyMessageViewDelegate <NSObject>

/*! 常用问题 */
- (void)allQues;
/*! 充值短信 */
- (void)payMessage;
/*! 返回 */
- (void)backpop;



@end

@interface PGMeMyMessageView : UIScrollView
/*! 剩余短信label */
@property(nonatomic,strong)UILabel *countLabel;

@property(nonatomic,weak) id<PGMeMyMessageViewDelegate> PGMeMyMessageViewDelegate;



@end
