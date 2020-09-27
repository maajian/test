#import <Foundation/Foundation.h>
@interface PGActivityConsultModel : NSObject<NSCoding>
@property(nonatomic,copy)NSString *AddTime;
@property(nonatomic,copy)NSString *Answer;
@property(nonatomic,copy)NSString *HeadImgurl;
@property(nonatomic,copy)NSString *NickName;
@property(nonatomic,copy)NSString *Question;
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,assign)NSInteger IsRecommend;
@property(nonatomic,assign)NSInteger IsReply;
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *Phone;
@end
