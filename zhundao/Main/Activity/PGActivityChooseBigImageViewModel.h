#import <Foundation/Foundation.h>
@interface PGActivityChooseBigImageViewModel : NSObject
- (NSMutableArray *)heightForCell :(NSArray *) array;
- (NSInteger)heightForRowAtIndexPath:(NSIndexPath *)indexPath
                              isPost:(BOOL)isPost
                         heightArray:(NSArray *)heightArray;
@end
