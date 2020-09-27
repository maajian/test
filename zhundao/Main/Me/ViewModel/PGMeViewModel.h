#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface PGMeViewModel : NSObject
@property (nonatomic, assign) BOOL allowPromote;
- (void)getPromoteSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;
@end
NS_ASSUME_NONNULL_END
