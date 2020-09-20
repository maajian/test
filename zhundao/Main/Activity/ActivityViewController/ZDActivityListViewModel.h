//
//  ZDActivityListViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/6/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^deleteBlock) (NSInteger isSuccess);
@interface ZDActivityListViewModel : NSObject
@property(nonatomic,strong)deleteBlock deleteBlock;

- (void)deletePersonWithID:(NSInteger) personID ;   //删除人员信息
/*! 修改审核状态 */
- (void)UpdateStatusActivityListId :(NSInteger)activityListId status :(BOOL)status  block :(deleteBlock)block;

/*! 转为线下支付 */
- (void)PayOffLine :(NSInteger)activityListId block :(deleteBlock)block;
@end
