//
//  ZDAvtivityMoreModalModel.h
//  zhundao
//
//  Created by maj on 2018/11/30.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MoreMoalType) {
    MoreMoalTypeEdit,
    MoreMoalTypePersonList,
    MoreMoalTypeConsult,
    MoreMoalTypeLink,
    MoreMoalTypeApplyEnd,
    MoreMoalTypeDelete,
    MoreMoalTypeShare,
    MoreMoalTypeInvite,
    MoreMoalTypeQRCode,
    MoreMoalTypeSignin,
    MoreMoalTypeCopy,
    MoreMoalTypeListOutput,
    MoreMoalTypeDataPerson,
    MoreMoalTypeStatistics, // 报名统计
};

@interface ZDAvtivityMoreModalModel : UICollectionReusableView
// 图片
@property (nonatomic, copy) NSString *imageStr;
// 标题
@property (nonatomic, copy) NSString *title;
// 小红点
@property (nonatomic, assign) BOOL isRed;
 // 类型
@property (nonatomic, assign) MoreMoalType moreMoalType;


// 编辑
+ (instancetype)editModel;
// 名单列表
+ (instancetype)personListModel;
// 咨询
+ (instancetype)consultModel;
// 活动链接
+ (instancetype)linkModel;
// 报名截止
+ (instancetype)applyEndModel;
// 删除活动
+ (instancetype)deleteModel;
// 分享活动
+ (instancetype)shareModel;
// 邀请函
+ (instancetype)inviteModel;
// 下载二维码
+ (instancetype)qrcodeModel;
// 签到管理
+ (instancetype)ZDSignInSigninModel;
// 活动复制
+ (instancetype)copyModel;
// 名单导出
+ (instancetype)listOutputModel;
// 数据员
+ (instancetype)dataPersonModel;
// 报名统计
+ (instancetype)statisticsModel;

@end

NS_ASSUME_NONNULL_END
