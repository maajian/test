//
//  MessageContentModel.m
//  zhundao
//
//  Created by zhundao on 2017/11/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "MessageContentModel.h"

@implementation MessageContentModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.ID = [dic[@"ID"] integerValue];
        self.es_content = dic[@"Msg_Info"] ? dic[@"Msg_Info"] : dic[@"es_content"];
        self.Reason = ZD_SafeValue(dic[@"Reason"]);
        if (dic[@"Status"]) {
            switch ([dic[@"Status"] integerValue]) {
                case 0:
                    self.messageStatusType = ZDMessageStatusTypeCheck;
                    break;
                case 1:
                    self.messageStatusType = ZDMessageStatusTypeSuccess;
                    break;
                case -1:
                    self.messageStatusType = ZDMessageStatusTypeFail;
                    break;
                    
                default:
                    break;
            }
        } else {
            self.messageStatusType = ZDMessageStatusTypeSuccess;
        }
    }
    return self;
}

@end
