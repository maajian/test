//
//  ZDDataPersonAddViewModel.m
//  jingjing
//
//  Created by maj on 2020/8/10.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDDataPersonAddViewModel.h"

@implementation ZDDataPersonAddViewModel

- (instancetype)init {
    if (self = [super init]) {
        _dataSource = @[
        [ZDDataPersonAddModel nameModel],
        [ZDDataPersonAddModel phoneModel],
        ].mutableCopy;
    }
    return self;
}

#pragma mark --- network
- (void)addDataPersonWithActivityId:(NSInteger)activityId userName:(NSString *)userName phone:(NSString *)phone success:(ZDBlock_Void)success failure:(ZDBlock_Error)failure{
    NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, ZD_UserM.token];
    NSDictionary *dic = @{@"BusinessCode": @"AddDataPersonForApp",
                          @"Data" : @{
                                  @"ActivityId":@(activityId),
                                  @"UserName":userName,
                                  @"Phone":phone
                         }
    };
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        if ([obj[@"res"] boolValue]) {
            ZDDo_Block_Safe_Main(success)
        } else {
            ZD_HUD_SHOW_ERROR_STATUS(obj[@"errmsg"]);
        }
    } fail:^(NSError *error) {
        ZDDo_Block_Safe_Main1(failure, error)
    }];
}

@end
