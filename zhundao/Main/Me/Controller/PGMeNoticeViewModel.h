//
//  PGMeNoticeViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/8/15.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGMeNoticeModel.h"
typedef void(^allBlock) (NSArray *array);
@interface PGMeNoticeViewModel : NSObject
 // 通知model
@property (nonatomic, copy) PGMeNoticeModel *noticeModel;

/*! 获取通知 */
- (void)netWorkWithPage:(NSInteger)page Block :(allBlock)allBlock ;
// 获取通知详情
- (void)getNoticeDetail:(NSInteger)ID successBlock:(kZDCommonSucc)successBlock failBlock:(kZDCommonFail)failBlock;

/*! 保存数据库 */
- (void)savaData:(NSArray *)array;
/*! 保存数据进plst文件 */
- (void)sava :(NSArray *)array;

/*! 清数据 */
- (void)removeData;

/*! 从plist文件中读取 */
- (NSArray *)getData;
/*! 保存ID */
- (void)signIsReadWithID :(NSInteger)ID;
/*! 保存时间 */
- (void)saveTime :(PGMeNoticeModel *)model;
@end
