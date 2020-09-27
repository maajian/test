#import <Foundation/Foundation.h>
typedef void(^markBlock) (BOOL isSuccess);
@interface PGActivitySignListViewModel : NSObject
- (NSMutableArray *)getRightArray:(NSDictionary *)datadic array :(NSArray *)array;
- (NSMutableArray *)getLastPostArray :(NSArray *)array;
- (void)removeNone:(NSMutableArray *)array;
- (void)payMent : (NSInteger)payment title :(NSString *)title array :(NSMutableArray *)array;
- (void)addADMark :(NSString *)adMark
         personID :(NSInteger)personID
         UserName :(NSString *)UserName
           Mobile :(NSString *)Mobile
         markBlock:(markBlock)markBlock;
@end
