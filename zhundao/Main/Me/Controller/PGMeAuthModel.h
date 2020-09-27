#import <Foundation/Foundation.h>
@interface PGMeAuthModel : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *idCard;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *idCardBack;
@property(nonatomic,strong)NSString *idCardFront;
@property(nonatomic,assign)NSInteger status;
@end
