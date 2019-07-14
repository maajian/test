//
//  ZDDiscoveEditApplyViewModel.h
//  zhundao
//
//  Created by maj on 2018/12/5.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDDiscoverCustomApplyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDDiscoveEditApplyViewModel : NSObject
// 填写列表数据
@property (nonatomic, strong) NSMutableArray<NSString *> *dataArray;
// 类型数组
@property (nonatomic, copy) NSArray<NSString *> *typeArray;
// 是否需要选择框
@property (nonatomic, assign) BOOL isNeedChoice;

// model
@property (nonatomic, strong) ZDDiscoverCustomApplyModel *model;

#pragma mark --- network

/**
 修改自定义报名项

 @param title 标题
 @param inputType 类型
 @param ID ID
 @param require 是否必填
 @param tips 填写提示
 @param choiceArray 选择数组
 @param success 成功回调
 @param failure 失败回调
 */
- (void)changeCustomtApplyWithTitle:(NSString *)title inputType:(ZDCustomType)inputType ID:(NSInteger)ID require:(BOOL)require tips:(NSString *)tips choiceArray:(NSArray *)choiceArray success:(kZDCommonSucc)success failure:(kZDCommonFail)failure;
- (void)newCustomApplyRequestWithTitle:(NSString *)title inputType:(ZDCustomType)inputType require:(BOOL)require tips:(NSString *)tips choiceArray:(NSArray *)choiceArray success:(ZDBlock_Dic)success failure:(kZDCommonFail)failure;

@end

NS_ASSUME_NONNULL_END
