#import <Foundation/Foundation.h>
typedef void(^listBlock) (NSArray *dataArray);
@interface PGDiscoverFaceViewModel : NSObject
- (void)getListWithBlock :(listBlock)liBlock;
- (void)saveData:(NSArray *)array ;
- (NSArray *)getData;
@end
