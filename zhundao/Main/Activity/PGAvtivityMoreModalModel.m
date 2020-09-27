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
+ (instancetype)editModel {
    return [[self alloc] initWithImageStr:@"img_more_edit" title:@"编辑活动" type:MoreMoalTypeEdit];
}
+ (instancetype)personListModel {
    return [[self alloc] initWithImageStr:@"img_more_list" title:@"报名名单" type:MoreMoalTypePersonList];
}
+ (instancetype)listOutputModel {
    return [[self alloc] initWithImageStr:@"img_more_out_put" title:@"名单导出" type:MoreMoalTypeListOutput];
}
+ (instancetype)dataPersonModel {
    return [[self alloc] initWithImageStr:@"img_more_data_person" title:@"管理员" type:MoreMoalTypeDataPerson];
}
+ (instancetype)PGActivityConsultModel {
    return [[self alloc] initWithImageStr:@"img_more_consult" title:@"活动咨询" type:MoreMoalTypeConsult];
}
+ (instancetype)linkModel {
    return [[self alloc] initWithImageStr:@"img_more_link" title:@"活动链接" type:MoreMoalTypeLink];
}
+ (instancetype)applyEndModel {
    return [[self alloc] initWithImageStr:@"img_more_end" title:@"报名截止" type:MoreMoalTypeApplyEnd];
}
+ (instancetype)deleteModel {
    return [[self alloc] initWithImageStr:@"img_more_delete" title:@"删除活动" type:MoreMoalTypeDelete];
}
+ (instancetype)shareModel {
    return [[self alloc] initWithImageStr:@"img_more_share" title:@"分享活动" type:MoreMoalTypeShare];
}
+ (instancetype)inviteModel {
    return [[self alloc] initWithImageStr:@"img_more_invite" title:@"邀请函" type:MoreMoalTypeInvite];
}
+ (instancetype)qrcodeModel {
    return [[self alloc] initWithImageStr:@"img_more_code" title:@"下载二维码" type:MoreMoalTypeQRCode];
}
+ (instancetype)PGSignInSigninModel {
    return [[self alloc] initWithImageStr:@"img_more_signin" title:@"签到管理" type:MoreMoalTypeSignin];
}
+ (instancetype)copyModel {
    return [[self alloc] initWithImageStr:@"img_more_copy" title:@"活动复制" type:MoreMoalTypeCopy];
}
+ (instancetype)statisticsModel {
    return [[self alloc] initWithImageStr:@"img_more_statistics" title:@"报名统计" type:MoreMoalTypeStatistics];
}
@end
