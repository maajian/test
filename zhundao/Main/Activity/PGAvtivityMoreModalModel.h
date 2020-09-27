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
    MoreMoalTypeStatistics, 
};
@interface PGAvtivityMoreModalModel : UICollectionReusableView
@property (nonatomic, copy) NSString *imageStr;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isRed;
@property (nonatomic, assign) MoreMoalType moreMoalType;
+ (instancetype)editModel;
+ (instancetype)personListModel;
+ (instancetype)PGActivityConsultModel;
+ (instancetype)linkModel;
+ (instancetype)applyEndModel;
+ (instancetype)deleteModel;
+ (instancetype)shareModel;
+ (instancetype)inviteModel;
+ (instancetype)qrcodeModel;
+ (instancetype)PGSignInSigninModel;
+ (instancetype)copyModel;
+ (instancetype)listOutputModel;
+ (instancetype)dataPersonModel;
+ (instancetype)statisticsModel;
@end
NS_ASSUME_NONNULL_END
