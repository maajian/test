//
//  ZDMeChangeInfoViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/11/1.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+block.h"
@interface ZDMeChangeInfoViewModel : NSObject

- (void)UpdateUserInfo :(NSDictionary *)dic
          successBlock :(ZDSuccessBlock)successBlock
            errorBlock : (ZDErrorBlock)errorBlock;

/*! 获取信息 */
- (void)getUserInfo:(ZDSuccessBlock)successBlock
        errorBlock : (ZDErrorBlock)errorBlock;
@end
