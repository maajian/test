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
@interface signResult : NSObject
@property(nonatomic,copy)maskBlock maskBlock;
- (void)showallWithFMResultSet:(FMResultSet *)rs  withdic:(NSDictionary *)acdic actionWithTitle1:(NSString *)title1 actionWithTitle2:(NSString *)title2  withAction1:(UIAlert)action1 withAction2:(UIAlert)action2 otherSign:(BOOL)otherSign withCtr:(UIViewController *)Ctr;
-(void)getDataWithData:(NSDictionary *)Data  WithStringValue:(NSString *)stringValue withID:(NSInteger)signID WithSignBool:(BOOL)signbool withSigncheckInWay:(NSInteger)checkInWay WithPhone:(NSString *)phone Withtitle1 :(NSString *)title1 Withtitle2 :(NSString *)title2 WithAction1 :(UIAlert)action3 WithAction1 :(UIAlert)action4 otherSign:(BOOL)otherSign WithCtr :(UIViewController *)Ctr;




- (void)sureSignWithphoneStr:(NSString *)phoneStr WithView :(UIView*)view WithSignId :(NSInteger)signid WithCtr :(UIViewController *)Ctr WithMaskLabelBool :(BOOL)MaskLabel WithTYaction1:(UIAlert)WillSignAction WithTYaction2:(UIAlert)SignedAction WithTYActionNotNet1:(UIAlert)WillSignAction1 WithTYActionNotNet2:(UIAlert)SignedAction2 maskBlock :(maskBlock)maskBlock;


@end
