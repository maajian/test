#import <Foundation/Foundation.h>
@interface PGDiscoverPriviteInviteViewModel : NSObject
- (NSDictionary *)writeNameFromPlist;
- (UIImage *)writeImage :(NSString *)name;
- (void)removePlistWithName:(NSString *)name;
- (NSInteger)getCurrentIndex;
- (void)savaCurrentIndex:(NSInteger)index;
@end
