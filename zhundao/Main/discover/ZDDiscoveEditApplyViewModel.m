//
//  ZDDiscoveEditApplyViewModel.m
//  zhundao
//
//  Created by maj on 2018/12/5.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "ZDDiscoveEditApplyViewModel.h"

@implementation ZDDiscoveEditApplyViewModel

- (instancetype)init {
    if (self = [super init]) {
        _typeArray = @[@"输入框",@"多文本",@"下拉框",@"多选框",@"图片",@"单选框",@"日期",@"数字"];
    }
    return self;
}

- (void)setModel:(ZDDiscoverCustomApplyModel *)model {
    _model = model;
    
    switch (model.customType) {
        case ZDCustomTypeImage:
        case ZDCustomTypeDate:
        case ZDCustomTypeOneText:
        case ZDCustomTypeMoreText:
        case ZDCustomTypeNumber:
            _isNeedChoice = NO;
            break;
        case ZDCustomTypePullDown:
        case ZDCustomTypeOneChoose:
        case ZDCustomTypeMoreChoose:
            _isNeedChoice = YES;
        default:
            break;
    }
    NSInteger type = _model.customType;
    _model.typeStr = _typeArray[type];
    model.typeStr = _typeArray[type];
    
    if (model.ID) {
        _dataArray = _model.optionArray.mutableCopy;
        if (_isNeedChoice && !_dataArray.count) {
            _dataArray =@[@"", @""].mutableCopy;
        }
    } else {
        if(_isNeedChoice) {
            _dataArray = @[@"", @""].mutableCopy;
        } else {
            _dataArray = @[].mutableCopy;
            
        }
        
    }
}

#pragma mark --- network

- (void)changeCustomtApplyWithTitle:(NSString *)title inputType:(ZDCustomType)inputType ID:(NSInteger)ID require:(BOOL)require tips:(NSString *)tips choiceArray:(NSArray *)choiceArray success:(kZDCommonSucc)success failure:(kZDCommonFail)failure{
//    /api/v2/activity/updateActivityOption
    NSString *option = @"";
    if (choiceArray.count) {
        option = [option stringByAppendingString:choiceArray.firstObject];
        for (int i = 1; i< choiceArray.count; i++) {
            option = [option stringByAppendingString:@"|"];
            option = [option stringByAppendingString:choiceArray[i]];
        }
    }
    
    NSString *url = [NSString stringWithFormat:@"%@api/v2/activity/updateActivityOption?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    NSDictionary *dic = @{@"id" : @(ID),
                          @"title" : title,
                          @"inputType" : @(inputType),
                          @"option" : option,
                          @"required" : @(require),
                          @"placeholder" : tips,
                          };
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *jsonStr = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    [ZD_NetWorkM postDataWithMethod:url parameters:jsonStr succ:^(NSDictionary *obj) {
        DDLogVerbose(@"res = %@",obj);
        success();
    } fail:^(NSError *error) {
        failure(error.description);
    }];
}

- (void)newCustomApplyRequestWithTitle:(NSString *)title inputType:(ZDCustomType)inputType require:(BOOL)require tips:(NSString *)tips choiceArray:(NSArray *)choiceArray success:(ZDBlock_Dic)success failure:(kZDCommonFail)failure {
    NSString *option = @"";
    if (choiceArray.count) {
        option = [option stringByAppendingString:choiceArray.firstObject];
        for (int i = 1; i< choiceArray.count; i++) {
            option = [option stringByAppendingString:@"|"];
            option = [option stringByAppendingString:choiceArray[i]];
        }
    }
    
    NSString *url = [NSString stringWithFormat:@"%@api/v2/activity/addActivityOption?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    NSDictionary *dic = @{@"title" : title,
                          @"inputType" : @(inputType),
                          @"option" : option,
                          @"required" : @(require),
                          @"hidden": @(NO),
                          @"placeholder" : tips,
                          };
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *jsonStr = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    [ZD_NetWorkM postDataWithMethod:url parameters:jsonStr succ:^(NSDictionary *obj) {
        DDLogVerbose(@"res = %@",obj);
        success(obj);
    } fail:^(NSError *error) {
        failure(error.description);
    }];
}

@end
