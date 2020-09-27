#import "PGMeModel.h"
@implementation PGMeModel
+ (instancetype)PG_modelWithImageName:(NSString *)imageName title:(NSString *)title type:(PGMeType)type {
    PGMeModel *model = [PGMeModel new];
    model.title = title;
    model.image = [UIImage imageNamed:imageName];
    model.type = type;
    return model;
}
+ (instancetype)headerModel {
    return [PGMeModel PG_modelWithImageName:@"" title:@"" type:PGMeTypeHeader];
}
+ (instancetype)PGMeNoticeModel {
    return [PGMeModel PG_modelWithImageName:@"com_public_notice_list" title:@"通知公告" type:PGMeTypeNotice];
}
+ (instancetype)walletModel {
    return [PGMeModel PG_modelWithImageName:@"img_public_wallet" title:@"我的钱包" type:PGMeTypeWallet];
}
+ (instancetype)messageModel {
    return [PGMeModel PG_modelWithImageName:@"img_public_message_blue" title:@"我的短信" type:PGMeTypeMessage];
}
+ (instancetype)PGMeContactModel {
    return [PGMeModel PG_modelWithImageName:@"com_public_contact_list" title:@"我的通讯录" type:PGMeTypeContact];
}
+ (instancetype)questionModel {
    return [PGMeModel PG_modelWithImageName:@"img_public_retroaction" title:@"我的工单" type:PGMeTypeQuestion];
}
+ (instancetype)personDataMessageModel {
    return [PGMeModel PG_modelWithImageName:@"com_public_notice_list" title:@"消息" type:PGMeTypePersonDataMessage];
}
+ (instancetype)honorModel {
    return [PGMeModel PG_modelWithImageName:@"img_me_honor" title:@"我的勋章" type:PGMeTypeHonor];
}
+ (instancetype)zhundaobiModel {
    return [PGMeModel PG_modelWithImageName:@"img_me_zhundaobi" title:@"我的准币" type:PGMeTypeZDBi];
}
+ (instancetype)voucherModel {
    return [PGMeModel PG_modelWithImageName:@"img_me_money" title:@"我的代金券" type:PGMeTypeVoucher];
}
+ (instancetype)promoteModel {
    return [PGMeModel PG_modelWithImageName:@"img_me_promote" title:@"准到合伙人" type:PGMeTypePromote];
}
+ (instancetype)settingModel {
    return [PGMeModel PG_modelWithImageName:@"img_public_me_setting" title:@"设置" type:PGMeTypeSetting];
}
@end
