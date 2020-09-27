#import <Foundation/Foundation.h>
@interface PGSignInLoadallsignModel : NSObject
@property (nonatomic,strong)NSString *Mobile;
@property (nonatomic,strong)NSString *SignTime;
@property(nonatomic,strong)NSString *TrueName;
@property(nonatomic,assign)NSInteger Status;
@property (nonatomic,assign )NSInteger UserID;
@property(nonatomic,copy)NSString *VCode;
@property(nonatomic,copy)NSString *AdminRemark;
@property(nonatomic,copy)NSString *FeeName;
@property(nonatomic,assign) double Fee;
@property(nonatomic,assign)NSInteger ActivityListID;
@end
