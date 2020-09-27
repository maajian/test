#import <Foundation/Foundation.h>
@interface PGMePersonInfoModel : NSObject
@property(nonatomic,copy)NSString *headImgurl;
@property(nonatomic,copy)NSString *trueName;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *email;
@property(nonatomic,assign) NSInteger Sex;
@property(nonatomic,copy)NSString *company;
@property(nonatomic,copy)NSString *industry;
@property(nonatomic,copy)NSString *duty;
@end
