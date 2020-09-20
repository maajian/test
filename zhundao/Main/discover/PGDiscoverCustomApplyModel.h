//
//  PGDiscoverCustomApplyModel.h
//  zhundao
//
//  Created by maj on 2018/12/1.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 输入类型（0：文本数据 1：多文本数据 2：下拉框 3：多选框 4：图片 5：单选框 6:日期控件 7:数字输入框
typedef NS_ENUM(NSInteger, ZDCustomType) {
    ZDCustomTypeOneText = 0, //文本数据
    ZDCustomTypeMoreText, //多文本数据
    ZDCustomTypePullDown, //下拉框
    ZDCustomTypeMoreChoose, //多选框
    ZDCustomTypeImage, // 图片
    ZDCustomTypeOneChoose, // 单选框
    ZDCustomTypeDate, // 日期控件
    ZDCustomTypeNumber, // 数组输入框
};

@interface PGDiscoverCustomApplyModel : NSObject
// 标题
@property (nonatomic, strong) NSString *title;
// 是否必填
@property (nonatomic, assign) NSInteger required;
// 类型
@property (nonatomic, assign) ZDCustomType customType;
// 类型字符串
@property (nonnull, assign) NSString *typeStr;
// 自定义项ID
@property (nonatomic, assign) NSInteger ID;
// 多选
@property (nonatomic, strong) NSString *option;
// 自定义相是否隐藏
@property (nonatomic, assign) BOOL hidden;
// 填写提示
@property (nonatomic, assign) NSString *placeholder;

// 多选数组
@property (nonatomic, copy) NSArray *optionArray;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
