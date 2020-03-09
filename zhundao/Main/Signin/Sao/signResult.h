//
//  signResult.h
//  zhundao
//
//  Created by zhundao on 2017/3/6.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^maskBlock)(BOOL maskIsSuccess);

typedef NS_ENUM(NSInteger, ZDSignType) {
    ZDSignTypeCode = 0,
    ZDSignTypePhone,
    ZDSignTypeAdmin,
};

@interface signResult : NSObject
@property(nonatomic,copy)maskBlock maskBlock;

- (void)dealPhoneSignWithSignID:(NSInteger)signID phone:(NSString *)phone  action1:(ZDBlock_Void)action1;
- (void)dealAdminSignWithSignID:(NSInteger)signID phone:(NSString *)phone action1:(ZDBlock_Void)action1;
- (void)dealCodeSignWithSignID:(NSInteger)signID vcode:(NSString *)vcode action1:(ZDBlock_Void)action1;

- (void)postLocalDataWithSignID:(NSInteger)signID success:(ZDBlock_Void)success fail:(ZDBlock_Void)fail;
@end
