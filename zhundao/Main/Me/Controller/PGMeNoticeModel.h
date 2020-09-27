#import <Foundation/Foundation.h>
@interface PGMeNoticeModel : NSObject<NSCoding>
@property(nonatomic,copy)NSString *AddTime;
@property(nonatomic,copy)NSString *Detail;
@property(nonatomic,copy)NSString *SortName;
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,assign)NSInteger ID;
@end
