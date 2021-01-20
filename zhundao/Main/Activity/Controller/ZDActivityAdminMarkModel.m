//
//  ZDActivityAdminMarkModel.m
//  zhundao
//
//  Created by maj on 2021/1/9.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDActivityAdminMarkModel.h"

@implementation ZDActivityAdminMarkModel

+ (ZDActivityAdminMarkModel *)markModelWithDic:(NSDictionary *)dic  {
    ZDActivityAdminMarkModel *model = [ZDActivityAdminMarkModel new];
    model.headerTitle = @"管理员备注";
    model.content = dic[@"AdminRemark"];
    model.type = ZDAdminMarkTypeMark;
    model.placeHolder = @"";
    return model;
}

+ (ZDActivityAdminMarkModel *)guestTypeModelWithDic:(NSDictionary *)dic  {
    ZDActivityAdminMarkModel *model = [ZDActivityAdminMarkModel new];
    model.headerTitle = @"嘉宾类型";
    NSString *GuestType = dic[@"GuestType"];
    model.content = GuestType.length ? GuestType : @"";
    model.type = ZDAdminMarkTypeGuestType;
    model.placeHolder = @"添加嘉宾类型，如VIP";
    return model;
}

+ (ZDActivityAdminMarkModel *)roomModelWithDic:(NSDictionary *)dic  {
    ZDActivityAdminMarkModel *model = [ZDActivityAdminMarkModel new];
    model.headerTitle = @"房号";
    NSString *Room = dic[@"Room"];
    model.content = Room.length ? Room : @"";
    model.type = ZDAdminMarkTypeRoom;
    model.placeHolder = @"";
    return model;
}

+ (ZDActivityAdminMarkModel *)seatModelWithDic:(NSDictionary *)dic  {
    ZDActivityAdminMarkModel *model = [ZDActivityAdminMarkModel new];
    model.headerTitle = @"座位";
    NSString *Seat = dic[@"Seat"];
    model.content = Seat.length ? Seat : @"";
    model.type = ZDAdminMarkTypeSeat;
    model.placeHolder = @"";
    return model;
}

+ (ZDActivityAdminMarkModel *)saveModel  {
    ZDActivityAdminMarkModel *model = [ZDActivityAdminMarkModel new];
    model.headerTitle = @"";
    model.content = @"";
    model.type = ZDAdminMarkTypeSave;
    model.placeHolder = @"";
    return model;
}

@end
