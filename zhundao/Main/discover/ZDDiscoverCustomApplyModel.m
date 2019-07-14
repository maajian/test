//
//  ZDDiscoverCustomApplyModel.m
//  zhundao
//
//  Created by maj on 2018/12/1.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "ZDDiscoverCustomApplyModel.h"

@implementation ZDDiscoverCustomApplyModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        // 标题
        self.title = dic[@"title"] ? dic[@"title"] : @"";
        // 必填
        self.required = dic[@"required"] ? [dic[@"required"] integerValue] : 0;
        // 类型
        switch ([dic[@"inputType"] integerValue]) {
            case 0:
                self.customType = ZDCustomTypeOneText;
                _typeStr = @"【输入框】";
                break;
            case 1:
                self.customType = ZDCustomTypeMoreText;
                _typeStr = @"【多文本】";
                break;
            case 2:
                self.customType = ZDCustomTypePullDown;
                _typeStr = @"【下拉框】";
                break;
            case 3:
                self.customType = ZDCustomTypeMoreChoose;
                 _typeStr = @"【多选框】";
                break;
            case 4:
                self.customType = ZDCustomTypeImage;
                _typeStr = @"【图  片】";
                break;
            case 5:
                self.customType = ZDCustomTypeOneChoose;
                _typeStr = @"【单  选】";
                break;
            case 6:
                self.customType = ZDCustomTypeDate;
                _typeStr = @"【日  期】";
                break;
            case 7:
                self.customType = ZDCustomTypeNumber;
                _typeStr = @"【数  字】";
                break;
                
            default:
                self.customType = ZDCustomTypeNumber;
                _typeStr = @"【数  字】";
                break;
        }
        
        // 自定义项ID
        self.ID = [dic[@"id"] integerValue];
        // 多选
        if (![dic[@"option"] isEqual:[NSNull null]]) {
            self.option = dic[@"option"];
            self.optionArray = [self.option componentsSeparatedByString:@"|"];
            if (self.optionArray.count < 2) self.optionArray = @[];
        } else {
            self.option = @"";
            self.optionArray = @[];
        }
        // 填写提示
        self.placeholder = [dic[@"placeholder"] isEqual:[NSNull null]] ? @"" : dic[@"placeholder"];
    
        // 自定义相是否隐藏
        self.hidden = [dic[@"hidden"] boolValue];
    }
    return self;
}

@end
