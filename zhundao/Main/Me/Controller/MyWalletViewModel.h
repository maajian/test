//
//  MyWalletViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/8/7.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^moneyBlock) (NSDictionary *moneyDic);
@interface MyWalletViewModel : NSObject

/*! 获取个人信息 */
- (void)getInfo :(moneyBlock)moneyBlock;
/*! 保存信息 */
- (void)saveWithdraw :(NSDictionary *)dic;
/*! 读取信息 */
- (NSDictionary *)readWithdraw;

@end
