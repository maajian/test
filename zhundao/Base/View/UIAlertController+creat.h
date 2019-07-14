//
//  UIAlertController+creat.h
//  zhundao
//
//  Created by zhundao on 2017/6/6.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^uiAlert) (UIAlertAction *action);
typedef void(^uiAlert1) (UIAlertAction *action1);
@interface UIAlertController (creat)
+(UIAlertController *)initWithTitle :(NSString *)title message :(NSString *)message sureAction :(uiAlert)alertAction;

+(UIAlertController *)initWithNotHaveTextFieldTitle :(NSString *)title message :(NSString *)message sureAction :(uiAlert)alertAction;

+(UIAlertController *)initWithHaveCancelAndSure :(NSString *)title message :(NSString *)message sureAction :(uiAlert)alertAction cancelAction :(uiAlert1)alertAction1;
@end
