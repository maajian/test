//
//  PGMeMoreAccountViewModel.h
//  zhundao
//
//  Created by xhkj on 2018/1/19.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+block.h"

#import "PGMeMoreAccountModel.h"
@interface PGMeMoreAccountViewModel : NSObject
/*! 用户登陆信息 */
@property (nonatomic, strong) NSMutableArray<PGMeMoreAccountModel *> *userArray;


/*! 获取列表数据 */
- (void)getListData:(dispatch_block_t)successBlock;

/*! 退出登录清空数据 */
- (void)didLogout;
@end
