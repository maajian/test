//
//  payTextField.h
//  zhundao
//
//  Created by zhundao on 2017/11/7.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol payTextFieldDelegate<NSObject>

- (void)sendPassWord :(NSString *)PS;

@end

@interface payTextField : UIView

@property(nonatomic,weak) id<payTextFieldDelegate> payTextFieldDelegate;

/*! 输入框 */
@property(nonatomic,strong)UITextField *textf;

/*! 初始化传值 */
- (instancetype)initWithFrame:(CGRect)frame
                  blackRadius:(NSInteger)blackRadius;


/*! 小黑点 */
@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,strong)UILabel *label3;
@property(nonatomic,strong)UILabel *label4;
@property(nonatomic,strong)UILabel *label5;
@property(nonatomic,strong)UILabel *label6;

@end
