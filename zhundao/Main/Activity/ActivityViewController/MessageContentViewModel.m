//
//  MessageContentViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/11/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "MessageContentViewModel.h"
#import "MessageContentModel.h"
@implementation MessageContentViewModel

- (instancetype)init {
    if (self = [super init]) {
        _customHeightArray = [NSMutableArray array];
        _systemHeightArray = [NSMutableArray array];
        _systemArray = [NSMutableArray array];
        _customArray = [NSMutableArray array];
    }
    return self;
}

//api/Sms/deleteContent/{id}
- (void)deleteContent :(NSInteger )ID
                  esid:(NSInteger)esid
          successBlock:(ZDSuccessBlock)successBlock
                 error:(ZDErrorBlock)errorBlock{
    AFmanager *manager = [AFmanager shareManager];
    NSString *str = [NSString stringWithFormat:@"%@api/sms/DeleteTemplate?id=%li&esid=%li",zhundaoMessageApi,ID,esid];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

- (void)addContent :(NSString * )content
                 ID:(NSInteger)ID
          successBlock:(ZDSuccessBlock)successBlock
                 error:(ZDErrorBlock)errorBlock{
    AFmanager *manager = [AFmanager shareManager];
    NSString *str = [NSString stringWithFormat:@"%@api/sms/AddTemplate",zhundaoMessageApi];
    NSDictionary *dic = @{@"es_id" :@(ID),
                          @"es_content" :content,
                          @"es_sort" : @(1),
                          @"remark" : @""
                          };
    [manager POST:str parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

- (void)getSystemWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Dic)success failure:(ZDBlock_Error_Str)failure {
    NSDictionary *dic = @{@"SortId" : @(1),
                          @"PageSize" : @(1000),
                          @"PageIndex" : [NSString stringWithFormat:@"%li",pageIndex]
                          };
    AFmanager *manager = [AFmanager shareManager];
    NSString *str = [NSString stringWithFormat:@"%@api/sms/GetDefaultTemplateList",zhundaoMessageApi];
    [manager POST:str parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_systemArray removeAllObjects];
        [_systemHeightArray removeAllObjects];
        for (NSDictionary *dic in responseObject[@"data"]) {
            MessageContentModel *model = [[MessageContentModel alloc] initWithDic:dic];
            model.isSystem = YES;
            [self.systemArray addObject:model];
            
            NSString *content = model.es_content;
            CGSize size = [content boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
            [self.systemHeightArray addObject:@(size.height + 20)];
        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error.description);
    }];
}
- (void)getCustomWithPageIndex:(NSInteger)pageIndex EsID:(NSInteger)EsID success:(ZDBlock_Dic)success failure:(ZDBlock_Error_Str)failure {
    NSDictionary *dic = @{@"SortId" : @(1),
                          @"PageSize" : @(1000),
                          @"PageIndex" : [NSString stringWithFormat:@"%li",pageIndex],
                          @"EsID" : @(EsID),
                          @"Status": @(-2)
                          };
    AFmanager *manager = [AFmanager shareManager];
    NSString *str = [NSString stringWithFormat:@"%@api/sms/GetTemplateList",zhundaoMessageApi];
    [manager POST:str parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_customArray removeAllObjects];
        [_customHeightArray removeAllObjects];
        for (NSDictionary *dic in responseObject[@"data"]) {
            MessageContentModel *model = [[MessageContentModel alloc] initWithDic:dic];
            model.isSystem = NO;
            [self.customArray addObject:model];
            
            NSString *content = model.es_content;
            CGSize size = [content boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
            [self.customHeightArray addObject:@(size.height + 40)];
        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error.description);
    }];
}


@end
