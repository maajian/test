//
//  PGLoginCodeFixView.h
//  jingjing
//
//  Created by maj on 2020/8/3.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PGLoginCodeFixView;
@protocol PGLoginCodeFixViewDelegate <NSObject>
// 关闭
- (void)PGLoginCodeFixView:(PGLoginCodeFixView *)loginCodeFixView didTapCloseButton:(UIButton *)button;
// next
- (void)PGLoginCodeFixView:(PGLoginCodeFixView *)loginCodeFixView didTapNextButton:(UIButton *)button;

@end

@interface PGLoginCodeFixView : UIView

@property (nonatomic, weak) id<PGLoginCodeFixViewDelegate> loginCodeFixViewDelegate;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *phoneStr;
 
@end

NS_ASSUME_NONNULL_END
