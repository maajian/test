//
//  ZDActivityMoreChioceModel.m
//  zhundao
//
//  Created by maj on 2021/3/30.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDActivityMoreChioceModel.h"

@implementation ZDActivityMoreChioceModel

+ (instancetype)imageModelWithUrl:(NSString *)url {
    ZDActivityMoreChioceModel *model = [ZDActivityMoreChioceModel new];
    model.moreChioceType = ZDActivityMoreChioceTypeImage;
    model.headerStr = @"分享小图(建议尺寸100*100)";
    model.title = model.detailTitle = @"";
    model.imageUrl = url;
    return model;
}

+ (instancetype)optionModel {
    ZDActivityMoreChioceModel *model = [ZDActivityMoreChioceModel new];
    model.moreChioceType = ZDActivityMoreChioceTypeOption;
    model.headerStr = @"默认姓名,手机 可前往 发现->自定义报名项 添加更多";
    model.title = @"报名填写项";
    model.detailTitle = @"多选";
    return model;
}

+ (instancetype)alertModel:(BOOL)isAlert {
    ZDActivityMoreChioceModel *model = [ZDActivityMoreChioceModel new];
    model.moreChioceType = ZDActivityMoreChioceTypeAlert;
    model.headerStr = @"有人报名，准到给您发提醒消息";
    model.title = @"用户报名提醒";
    model.detailTitle = @"";
    model.isAlert = isAlert;
    return model;
}

+ (instancetype)showListModel:(NSInteger)showList {
    ZDActivityMoreChioceModel *model = [ZDActivityMoreChioceModel new];
    model.moreChioceType = ZDActivityMoreChioceTypeShowList;
    model.headerStr = @"开启后，活动详情页将不再显示报名人数";
    model.title = @"隐藏报名名单";
    model.showListType = showList;
    NSArray *titleArray = @[@"显示人数和头像姓名", @"显示人数和头像昵称", @"显示人数", @"隐藏"];
    model.detailTitle = titleArray[showList];
    return model;
}

@end
