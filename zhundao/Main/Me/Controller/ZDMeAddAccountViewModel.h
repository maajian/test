//
//  ZDMeAddAccountViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/9/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AddAccountBlock) (BOOL isSuccess);

@interface ZDMeAddAccountViewModel : NSObject

/*! 添加账号 */
- (void)AddCreadCards :(NSDictionary *)dic  AddAccountBlock:(AddAccountBlock)AddAccountBlock;
/*! 是否可以添加账户 */
- (BOOL)isCanPost :(NSDictionary *)postdic;

@end
