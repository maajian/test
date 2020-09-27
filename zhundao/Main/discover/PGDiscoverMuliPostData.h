#import <Foundation/Foundation.h>
typedef void(^updataBlock) (BOOL isSuccess);
@interface PGDiscoverMuliPostData : NSObject
@property(nonatomic,copy)updataBlock updataBlock;
- (void)postWithView :(UIView *)view isShow :(BOOL)isShow acckey:(NSString *)acckey;
@end
