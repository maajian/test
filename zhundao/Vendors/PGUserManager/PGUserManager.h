#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
#define ZD_UserM [PGUserManager shareManager]
@interface PGUserManager : NSObject
+ (instancetype)shareManager;
@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, assign) CGFloat balance;
@property (nonatomic, assign) CGFloat factorageRate;
@property (nonatomic, assign) NSInteger gradeId;
@property (nonatomic, assign) BOOL hasPayPassWord;
@property (nonatomic, assign) NSInteger userSex;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *duty;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *headImgUrl;
@property (nonatomic, copy) NSString *idCard;
@property (nonatomic, copy) NSString *industry;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *trueName;
#pragma mark --- 扩展
@property (nonatomic, assign) BOOL hasShowPrivacy;
@property (nonatomic, assign) BOOL loginExpired;
@property (nonatomic, assign) BOOL isAdmin; 
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *loginAccount;
#pragma mark --- public
- (void)initWithDic:(NSDictionary *)dic;
- (void)saveLoginTime;
- (BOOL)hasLocalSign:(NSInteger)signID;
- (void)markLocalSign:(NSInteger)signID;
- (void)removeLocalSign:(NSInteger)signID;
- (void)didLogout;
@end
NS_ASSUME_NONNULL_END
