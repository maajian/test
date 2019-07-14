//
//  GroupMV.h
//  zhundao
//
//  Created by zhundao on 2017/5/24.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^backBlock) (NSArray *array);
typedef void(^addPersonBlock) (BOOL isSuccess);
@interface GroupMV : NSObject
@property(nonatomic,copy)backBlock block;
@property(nonatomic,copy)addPersonBlock addPersonBlock;
- (void)netWorkWithStr :(NSString *)str; //获取分组

//- (void)netWorkCreateGroupWithStr :(NSString *)str;   //创建分组
- (void)addPersonToGroupWithDic :(NSDictionary *)dic ; //联系人加入分组


- (NSArray *)searchDatabaseFromID:(NSInteger )ID;


- (void)searchDatabaseFromID:(NSInteger )groupID GroupName :(NSString *)GroupName  ID:(NSInteger )ID;  //更新数据库
@end
