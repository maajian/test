//
//  MyMessageView.h
//  zhundao
//
//  Created by zhundao on 2017/11/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyMessageViewDelegate <NSObject>

/*! 常用问题 */
- (void)allQues;
/*! 充值短信 */
- (void)payMessage;
/*! 返回 */
- (void)backpop;

- (void)showModel;

@end

@interface MyMessageView : UIView
/*! 剩余短信label */
@property(nonatomic,strong)UILabel *countLabel;

@property(nonatomic,weak) id<MyMessageViewDelegate> MyMessageViewDelegate;



@end
