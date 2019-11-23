//
//  signResult.h
//  zhundao
//
//  Created by zhundao on 2017/3/6.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^UIAlert) (TYAlertAction *action1);
typedef void(^maskBlock)(BOOL maskIsSuccess);

typedef NS_ENUM(NSInteger, ZDSignType) {
    ZDSignTypeCode = 0,
    ZDSignTypePhone,
    ZDSignTypeAdmin,
};

@interface signResult : NSObject
@property(nonatomic,copy)maskBlock maskBlock;

- (void)dealPhoneSignWithSignID:(NSInteger)signID phone:(NSString *)phone Ctr:(UIViewController *)Ctr title1:(NSString *)title1 title2 :(NSString *)title2 action1:(UIAlert)action1 action2 :(UIAlert)action2;
- (void)dealAdminSignWithSignID:(NSInteger)signID phone:(NSString *)phone Ctr:(UIViewController *)Ctr title1:(NSString *)title1 action1:(UIAlert)action1;
- (void)dealCodeSignWithSignID:(NSInteger)signID vcode:(NSString *)vcode Ctr:(UIViewController *)Ctr title1:(NSString *)title1 title2 :(NSString *)title2 action1:(UIAlert)action1 action2 :(UIAlert)action2;

- (void)postLocalDataWithSignID:(NSInteger)signID success:(ZDBlock_Void)success fail:(ZDBlock_Void)fail;
@end
