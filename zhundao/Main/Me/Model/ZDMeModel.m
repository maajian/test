//
//  ZDMeModel.m
//  zhundao
//
//  Created by maj on 2020/1/20.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMeModel.h"

@implementation ZDMeModel

+ (instancetype)modelWithImageName:(NSString *)imageName title:(NSString *)title type:(ZDMeType)type {
    ZDMeModel *model = [ZDMeModel new];
    model.title = title;
    model.image = [UIImage imageNamed:imageName];
    model.type = type;
    return model;
}

+ (instancetype)headerModel {
    return [ZDMeModel modelWithImageName:@"" title:@"" type:ZDMeTypeHeader];
}
+ (instancetype)ZDMeNoticeModel {
    return [ZDMeModel modelWithImageName:@"通知公告" title:@"通知公告" type:ZDMeTypeNotice];
}
+ (instancetype)walletModel {
    return [ZDMeModel modelWithImageName:@"wallet" title:@"我的钱包" type:ZDMeTypeWallet];
}
+ (instancetype)messageModel {
    return [ZDMeModel modelWithImageName:@"短信120" title:@"我的短信" type:ZDMeTypeMessage];
}
+ (instancetype)ZDMeContactModel {
    return [ZDMeModel modelWithImageName:@"通讯录" title:@"我的通讯录" type:ZDMeTypeContact];
}
+ (instancetype)questionModel {
    return [ZDMeModel modelWithImageName:@"retroaction" title:@"我的工单" type:ZDMeTypeQuestion];
}
+ (instancetype)personDataMessageModel {
    return [ZDMeModel modelWithImageName:@"通知公告" title:@"消息" type:ZDMeTypePersonDataMessage];
}
+ (instancetype)honorModel {
    return [ZDMeModel modelWithImageName:@"img_me_honor" title:@"我的勋章" type:ZDMeTypeHonor];
}
+ (instancetype)zhundaobiModel {
    return [ZDMeModel modelWithImageName:@"img_me_zhundaobi" title:@"我的准币" type:ZDMeTypeZDBi];
}
+ (instancetype)voucherModel {
    return [ZDMeModel modelWithImageName:@"img_me_money" title:@"我的代金券" type:ZDMeTypeVoucher];
}
+ (instancetype)promoteModel {
    return [ZDMeModel modelWithImageName:@"img_me_promote" title:@"准到合伙人" type:ZDMeTypePromote];
}
+ (instancetype)settingModel {
    return [ZDMeModel modelWithImageName:@"setting" title:@"设置" type:ZDMeTypeSetting];
}

@end
