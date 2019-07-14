//
//  SignUpViewModel.m
//  zhundao
//
//  Created by xhkj on 2018/4/24.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "SignUpViewModel.h"

@implementation SignUpViewModel

- (instancetype)init {
    if (self = [super init]) {
        _dataArray = [NSMutableArray array];
        _xLabelArray = [NSMutableArray array];
        _personCountArray = [NSMutableArray array];
    }
    return self;
}

/*! 根据时间获取报名人数数据 */
- (void)getActivityListDate:(NSInteger)activityId
                  beginDate:(NSString *)beginDate
                    endDate:(NSString *)endDate
               successBlock:(kZDCommonSucc)successBlock
                  failBlock:(kZDCommonFail)failBlock{
    AFmanager *manager = [AFmanager shareManager];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [manager GET:[NSString stringWithFormat:@"%@api/v2/dataCube/getActivityListDate?token=%@&activityId=%li&beginDate=%@&endDate=%@",zhundaoApi,token,(long)activityId,beginDate,endDate] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_dataArray removeAllObjects];
        [_xLabelArray removeAllObjects];
        
        for (NSDictionary *dic in responseObject[@"data"]) {
            SignUpModel *model = [[SignUpModel alloc] initWithDic:dic];
            [_dataArray addObject:[NSString stringWithFormat:@"%li",(long)model.count]];
            [_xLabelArray addObject:model.date];
        }
        
        successBlock();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        failBlock(error.description);
    }];
}

/*! 获取浏览人数数据 */
- (void)getActivityReadDate:(NSInteger)activityId
                  beginDate:(NSString *)beginDate
                    endDate:(NSString *)endDate
               successBlock:(kZDCommonSucc)successBlock
                  failBlock:(kZDCommonFail)failBlock {
    
    AFmanager *manager = [AFmanager shareManager];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [manager GET:[NSString stringWithFormat:@"%@api/v2/dataCube/getActivityReadDate?token=%@&activityId=%li&beginDate=%@&endDate=%@",zhundaoApi,token,(long)activityId,beginDate,endDate] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_dataArray removeAllObjects];
        [_xLabelArray removeAllObjects];
        
        for (NSDictionary *dic in responseObject[@"data"]) {
            SignUpModel *model = [[SignUpModel alloc] initWithDic:dic];
            [_dataArray addObject:[NSString stringWithFormat:@"%li",model.count]];
            [_xLabelArray addObject:model.date];
        }
        
        successBlock();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        failBlock(error.description);
    }];
}

/*! 付款人数 */
- (void)getFeePeopleNoDate:(NSInteger)activityId
              successBlock:(kZDCommonSucc)successBlock
                 failBlock:(kZDCommonFail)failBlock {
    AFmanager *manager = [AFmanager shareManager];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [manager GET:[NSString stringWithFormat:@"%@api/v2/dataCube/getFeePeopleNoDate?token=%@&activityId=%li",zhundaoApi,token,(long)activityId] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"errcode"] integerValue] == 0) {
            if ( [responseObject[@"data"][@"total"] integerValue] - [responseObject[@"data"][@"unpaid"] integerValue] == 0) {
                failBlock(@"该活动暂无收入");
            } else {
                [_personCountArray addObject:@[@"付款人数", responseObject[@"data"][@"paid"]]];
                [_personCountArray addObject:@[@"未付款人数", responseObject[@"data"][@"unpaid"]]];
                successBlock();
            }
        } else {
             failBlock(@"该活动暂无收入");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        failBlock(error.description);
    }];
}

/*! 项目收入 */
- (void)getEachFeeDate:(NSInteger)activityId
              successBlock:(kZDCommonSucc)successBlock
                 failBlock:(kZDCommonFail)failBlock {
    AFmanager *manager = [AFmanager shareManager];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [manager GET:[NSString stringWithFormat:@"%@api/v2/dataCube/getEachFeeDate?token=%@&activityId=%li",zhundaoApi,token,activityId] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"errcode"] integerValue] == 0) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                SignUpModel *model = [[SignUpModel alloc] initWithDic:dic];
                [_dataArray addObject:model];
            }
        }
        
        successBlock();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        failBlock(error.description);
    }];
}

@end
