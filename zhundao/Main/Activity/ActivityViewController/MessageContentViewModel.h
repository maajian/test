//
//  MessageContentViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/11/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageContentModel.h"
#import "NSObject+block.h"
@interface MessageContentViewModel : NSObject

#pragma mark--- 网络请求

/*! 删除 */
- (void)deleteContent :(NSInteger )ID
                  esid:(NSInteger)esid
          successBlock:(ZDSuccessBlock)successBlock
                 error:(ZDErrorBlock)errorBlock;

/*! 新增 */
- (void)addContent :(NSString * )content
                 ID:(NSInteger)ID
       successBlock:(ZDSuccessBlock)successBlock
              error:(ZDErrorBlock)errorBlock;

// 系统
- (void)getSystemWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Dic)success failure:(ZDBlock_Error_Str)failure ;
// 自定义
- (void)getCustomWithPageIndex:(NSInteger)pageIndex EsID:(NSInteger)EsID success:(ZDBlock_Dic)success failure:(ZDBlock_Error_Str)failure ;

@property (nonatomic, strong) NSMutableArray *systemHeightArray;
@property (nonatomic, strong) NSMutableArray<MessageContentModel *> *systemArray;

@property (nonatomic, strong) NSMutableArray *customHeightArray;
@property (nonatomic, strong) NSMutableArray<MessageContentModel *> *customArray;

@end
