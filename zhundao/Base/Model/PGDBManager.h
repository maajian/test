//
//  PGDBManager.h
//  zhundao
//
//  Created by zhundao on 2017/7/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

typedef void(^searchBlock) (BOOL isSuccess);
@interface PGDBManager : NSObject
@property(nonatomic,strong)FMDatabase *dataBase;
@property(nonatomic,copy)searchBlock  searchBlock;
+ (PGDBManager *)shareManager ;


/*! 创建数据库 */
- (void)createDatabase  ;
/*! 创建表 */
- (void)createTable :(NSString *)sqlStr;
/*! 删除表 */
- (void)deleteData:(NSString *)sqlStr;
/*! 查询表 */
- (void)searchData:(NSString *)sqlStr;
@end
