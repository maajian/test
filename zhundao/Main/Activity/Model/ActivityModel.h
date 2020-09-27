#import <Foundation/Foundation.h>
@interface ActivityModel : NSObject
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *Content;
@property(nonatomic,copy)NSString *Address;
@property(nonatomic,copy)NSString *ShareImgurl;
@property(nonatomic,copy)NSString *TimeStart;
@property(nonatomic,copy)NSString *TimeStop;
@property(nonatomic,copy)NSString *EndTime;
@property(nonatomic,copy)NSString *StartTime;
@property(nonatomic,assign)float Amount;
@property(nonatomic,assign)NSInteger Status;
@property(nonatomic,assign)NSInteger UserLimit;
@property(nonatomic,assign)NSInteger HasJoinNum;
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,assign)NSInteger ClickNo;
@property(nonatomic,strong)NSArray *ActivityFees;
@property(nonatomic,assign)NSInteger Alert;
@property(nonatomic,copy)NSString *BackImgurl;
@property(nonatomic,copy)NSString *ExtraUserInfo;
@property(nonatomic,copy)NSString *UserInfo;
@property(nonatomic,assign)NSInteger Fee;
@property(nonatomic,assign)NSInteger HideInfo;
@property(nonatomic,assign)NSInteger UserID;
@property(nonatomic,assign)double Lat;
@property(nonatomic,assign)double Lng;
@property (nonatomic, assign) NSInteger MinPeople;
@property (nonatomic, assign) NSInteger MaxPeople;
@property(nonatomic,assign)NSInteger ActivityGenre;
@property (nonatomic, assign) NSInteger total; 
@property (nonatomic, assign) NSInteger yesterday; 
@property (nonatomic, assign) NSInteger today; 
@end
