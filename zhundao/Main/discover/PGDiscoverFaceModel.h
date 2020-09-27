#import <Foundation/Foundation.h>
@interface PGDiscoverFaceModel : NSObject<NSCoding>
@property(nonatomic,copy)NSString *Name;
@property(nonatomic,copy)NSString *deviceKey;
@property(nonatomic,assign)NSInteger stock;
@property(nonatomic,strong)NSString *checkInName ;
@property(nonatomic,assign)NSInteger checkInId;
@end
