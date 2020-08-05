//
//  moreModalModel.m
//  zhundao
//
//  Created by maj on 2018/11/30.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "moreModalModel.h"

@implementation moreModalModel

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
    return [[self alloc] initWithImageStr:@"more编辑.png" title:@"编辑活动" type:MoreMoalTypeEdit];
}

// 名单列表
+ (instancetype)personListModel {
    return [[self alloc] initWithImageStr:@"more名单.png" title:@"报名名单" type:MoreMoalTypePersonList];
}
// 名单导出
+ (instancetype)listOutputModel {
    return [[self alloc] initWithImageStr:@"more名单.png" title:@"名单导出" type:MoreMoalTypeListOutput];
}
// 数据员
+ (instancetype)dataPersonModel {
    return [[self alloc] initWithImageStr:@"more名单.png" title:@"报数据员" type:MoreMoalTypeDataPerson];
}

// 咨询
+ (instancetype)consultModel {
    return [[self alloc] initWithImageStr:@"more咨询.png" title:@"活动咨询" type:MoreMoalTypeConsult];
}

// 活动链接
+ (instancetype)linkModel {
    return [[self alloc] initWithImageStr:@"more打开连接.png" title:@"活动链接" type:MoreMoalTypeLink];
}

// 报名截止
+ (instancetype)applyEndModel {
    return [[self alloc] initWithImageStr:@"more截止.png" title:@"报名截止" type:MoreMoalTypeApplyEnd];
}

// 删除活动
+ (instancetype)deleteModel {
    return [[self alloc] initWithImageStr:@"more删除.png" title:@"删除活动" type:MoreMoalTypeDelete];
}

// 分享活动
+ (instancetype)shareModel {
    return [[self alloc] initWithImageStr:@"more分享.png" title:@"分享活动" type:MoreMoalTypeShare];
}

// 邀请函
+ (instancetype)inviteModel {
    return [[self alloc] initWithImageStr:@"more邀请函.png" title:@"邀请函" type:MoreMoalTypeInvite];
}

// 下载二维码
+ (instancetype)qrcodeModel {
    return [[self alloc] initWithImageStr:@"more二维码.png" title:@"下载二维码" type:MoreMoalTypeQRCode];
}

// 签到管理
+ (instancetype)signinModel {
    return [[self alloc] initWithImageStr:@"more所有签到.png" title:@"签到管理" type:MoreMoalTypeSignin];
}

// 活动复制
+ (instancetype)copyModel {
    return [[self alloc] initWithImageStr:@"more复制.png" title:@"活动复制" type:MoreMoalTypeCopy];
}

@end
