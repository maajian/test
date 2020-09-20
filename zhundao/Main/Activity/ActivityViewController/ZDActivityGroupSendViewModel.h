//
//  ZDActivityGroupSendViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/11/2.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+block.h"
@interface ZDActivityGroupSendViewModel : NSObject

#pragma mark ---- network

/*! 开通短信 */
- (void)openMessage:(ZDSuccessBlock)successBlock
              error:(ZDErrorBlock)error ;
/*! 获取短信用户信息 这里获取签名*/
- (void)getAdminInfo:(ZDSuccessBlock)successBlock
               error:(ZDErrorBlock)errorBlock;

- (void)topUpSMS :(NSString *)password
           count :(NSInteger)count
     successBlock:(ZDSuccessBlock)successBlock
            error:(ZDErrorBlock)errorBlock;

/*! 发送 */
/*! 发送 */
- (void)sendWithSelectArray :(NSArray *)selectArray
                 modelArray :(NSArray *)modelArray
                        esid:(NSInteger)esid
                  activityId:(NSInteger)activityId
                    content :(NSString *)content
                successBlock:(ZDSuccessBlock)successBlock
                       error:(ZDErrorBlock)errorBlock;
/*! 文案选择 */
- (void)getContent:(ZDSuccessBlock)successBlock
             error:(ZDErrorBlock)errorBlock;

#pragma mark --- tableView
/*! row */
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
/*! 底部高度 */
- (NSInteger)heightForFooterInSection:(NSInteger)section;
/*! 头部高度 */
- (NSInteger)heightForHeaderInSection:(NSInteger)section;
/*! cell高度 */
- (NSInteger)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
