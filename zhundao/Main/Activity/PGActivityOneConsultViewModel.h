#import <Foundation/Foundation.h>
typedef void(^postBlock) (BOOL isSuccess);
@interface PGActivityOneConsultViewModel : NSObject
- (void)postData:(NSInteger)ConsultID answer :(NSString *)answer IsRecommend :(BOOL)IsRecommend postBlock:(postBlock)postBlock;
- (float)getHeight:(NSString *)str width :(float)width;
@end
