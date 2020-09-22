//
//  PGAvtivityMoreModalModel.m
//  zhundao
//
//  Created by maj on 2018/11/30.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "PGAvtivityMoreModalModel.h"

@implementation PGAvtivityMoreModalModel

- (instancetype)initWithImageStr:(NSString *)imageStr title:(NSString *)title type:(MoreMoalType)type {
    if (self = [super init]) {
        self.imageStr = imageStr;
        self.title = title;
        self.moreMoalType = type;
        self.isRed = NO;
    }
    return self;
}

// 编辑
+ (instancetype)editModel {
    return [[self alloc] initWithImageStr:@"img_more_edit" title:@"编辑活动" type:MoreMoalTypeEdit];
}

// 名单列表
+ (instancetype)personListModel {
    return [[self alloc] initWithImageStr:@"img_more_list" title:@"报名名单" type:MoreMoalTypePersonList];
}
// 名单导出
+ (instancetype)listOutputModel {
    return [[self alloc] initWithImageStr:@"img_more_out_put" title:@"名单导出" type:MoreMoalTypeListOutput];
}
// 数据员
+ (instancetype)dataPersonModel {
    return [[self alloc] initWithImageStr:@"img_more_data_person" title:@"管理员" type:MoreMoalTypeDataPerson];
}

// 咨询
+ (instancetype)PGActivityConsultModel {
    return [[self alloc] initWithImageStr:@"img_more_consult" title:@"活动咨询" type:MoreMoalTypeConsult];
}

// 活动链接
+ (instancetype)linkModel {
    return [[self alloc] initWithImageStr:@"img_more_link" title:@"活动链接" type:MoreMoalTypeLink];
}

// 报名截止
+ (instancetype)applyEndModel {
    return [[self alloc] initWithImageStr:@"img_more_end" title:@"报名截止" type:MoreMoalTypeApplyEnd];
}

// 删除活动
+ (instancetype)deleteModel {
    return [[self alloc] initWithImageStr:@"img_more_delete" title:@"删除活动" type:MoreMoalTypeDelete];
}

// 分享活动
+ (instancetype)shareModel {
    return [[self alloc] initWithImageStr:@"img_more_share" title:@"分享活动" type:MoreMoalTypeShare];
}

// 邀请函
+ (instancetype)inviteModel {
    return [[self alloc] initWithImageStr:@"img_more_invite" title:@"邀请函" type:MoreMoalTypeInvite];
}

// 下载二维码
+ (instancetype)qrcodeModel {
    return [[self alloc] initWithImageStr:@"img_more_code" title:@"下载二维码" type:MoreMoalTypeQRCode];
}

// 签到管理
+ (instancetype)PGSignInSigninModel {
    return [[self alloc] initWithImageStr:@"img_more_signin" title:@"签到管理" type:MoreMoalTypeSignin];
}

// 活动复制
+ (instancetype)copyModel {
    return [[self alloc] initWithImageStr:@"img_more_copy" title:@"活动复制" type:MoreMoalTypeCopy];
}

// 报名统计
+ (instancetype)statisticsModel {
    return [[self alloc] initWithImageStr:@"img_more_statistics" title:@"报名统计" type:MoreMoalTypeStatistics];
}


@end
