//
//  PGActivitySignListViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/6/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^markBlock) (BOOL isSuccess);
@interface PGActivitySignListViewModel : NSObject

// 转化
- (NSMutableArray *)getRightArray:(NSDictionary *)datadic array :(NSArray *)array;
- (NSMutableArray *)getLastPostArray :(NSArray *)array;

//移除未填写
- (void)removeNone:(NSMutableArray *)array;

/*! 修改付款名称 */
- (void)payMent : (NSInteger)payment title :(NSString *)title array :(NSMutableArray *)array;

/*! 添加管理员备注 */
- (void)addADMark :(NSString *)adMark
         personID :(NSInteger)personID
         UserName :(NSString *)UserName
           Mobile :(NSString *)Mobile
         markBlock:(markBlock)markBlock;
@end
