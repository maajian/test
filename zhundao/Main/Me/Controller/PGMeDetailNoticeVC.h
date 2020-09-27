#import "PGBaseVC.h"
typedef void(^isLoadBlock)(BOOL isload);
@interface PGMeDetailNoticeVC : PGBaseVC
@property(nonatomic,copy) NSString   *detail ;
@property(nonatomic,copy) NSString   *detailTitle ;
@property(nonatomic, assign) NSInteger ID;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)isLoadBlock  isLoadBlock;
@property (nonatomic, assign) BOOL isNotificationPush;
@end
