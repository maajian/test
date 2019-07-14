//
//  ContactMV.h
//  zhundao
//
//  Created by zhundao on 2017/5/23.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactModel.h"
typedef void(^backBlock) (NSArray *array);
typedef void(^searchBlcok) (NSArray *nameArray,NSArray *phoneArray,NSArray *numberArray,NSArray *companyArray);
@interface ContactMV : NSObject
@property(nonatomic,copy)backBlock block;
@property(nonatomic,copy)searchBlcok searchBlcok;
- (void)netWorkWithStr :(NSString *)str;   //获取人员名单数据

- (void)netWorkGroupSave; //保存群组信息

- (NSMutableArray *)searchAllData ; //，没网时获取名单数据

- (void)deleteDataHaveNetWithStr:(NSString *)str;   //删除个人数据

- (NSArray *)searchDatabaseFromID:(NSInteger )ID;   //根据ID 获取个人信息

- (NSArray *)sortWithArray :(NSArray *)sortArray;//字母排序

-(NSDictionary *)getdicWithArray:(NSArray *)dataarray isHaveNet :(BOOL) isHave; //获取数据并是否保存数据库

- (void)createSignList;

- (void)deleteDataWithModel :(NSInteger)personID;
@end
