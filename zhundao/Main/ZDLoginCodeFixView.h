//
//  ZDLoginCodeFixView.h
//  jingjing
//
//  Created by maj on 2020/8/3.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZDLoginCodeFixView;
@protocol ZDLoginCodeFixViewDelegate <NSObject>
// 关闭
- (void)ZDLoginCodeFixView:(ZDLoginCodeFixView *)loginCodeFixView didTapCloseButton:(UIButton *)button;
// next
- (void)ZDLoginCodeFixView:(ZDLoginCodeFixView *)loginCodeFixView didTapNextButton:(UIButton *)button;

@end

@interface ZDLoginCodeFixView : UIView

@property (nonatomic, weak) id<ZDLoginCodeFixViewDelegate> loginCodeFixViewDelegate;

@property (nonatomic, strong) NSString *code;

@end

NS_ASSUME_NONNULL_END
