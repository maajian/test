//
//  ZDDiscoverInviteTextView.h
//  zhundao
//
//  Created by zhundao on 2017/9/22.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol inviteTextDelegate <NSObject>
/*! 取消编辑事件 */
- (void)cancelAction;
/*! 确定编辑完成 */
- (void)sureBtnClick :(NSString *)content color :(UIColor *)selectColor fontsize:(float)fontsize;

@end

@interface ZDDiscoverInviteTextView : UITextView

- (instancetype)initWithColor:(UIColor *)color fontsize:(float)fontsize;
/*! 当前颜色 */
@property(nonatomic,strong)UIColor *currentColor;
/*! 当前文字字体大小 */
@property(nonatomic,assign)CGFloat currentFontsize;
/*! 回调 */
@property(nonatomic,weak) id<inviteTextDelegate> inviteTextDelegate;
/*! 内容 */
@property(nonatomic,strong)NSString *content;
/*! 是否是固定项 */
@property(nonatomic,assign)BOOL isFix;
@end
