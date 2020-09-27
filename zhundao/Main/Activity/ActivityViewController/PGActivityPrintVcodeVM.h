#import <Foundation/Foundation.h>
#import "PGActivityListModel.h"
@interface PGActivityPrintVcodeVM : NSObject
- (NSMutableArray *)getID :(NSArray * )nowArray model:(PGActivityListModel *)model;
- (NSArray *)getNameArray;
@end
