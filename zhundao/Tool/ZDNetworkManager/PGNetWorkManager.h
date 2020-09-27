#import <Foundation/Foundation.h>
#import "PGMacro.h"
#define ZD_NetWorkM [PGNetWorkManager sharedNetWorkManager]
@interface PGNetWorkManager : NSObject
+ (instancetype)sharedNetWorkManager;
+ (AFHTTPSessionManager *)shareHTTPSessionManager;
@property (nonatomic, assign) AFNetworkReachabilityStatus networkStatus;
- (void)autoChangeLine;
- (void)getDataWithMethod:(NSString *)method parameters:(id)parameters succ:(ZDBlock_Dic)succ fail:(ZDBlock_Error)fail;
- (void)postDataWithMethod:(NSString *)method parameters:(id)parameters succ:(ZDBlock_Dic)succ fail:(ZDBlock_Error)fail;
- (void)postDataWithMethod:(NSString *)method parameters:(id)parameters constructing:(void (^)(id<AFMultipartFormData> formData))constructing succ:(ZDBlock_Dic)succ fail:(ZDBlock_Error)fail;
@end
