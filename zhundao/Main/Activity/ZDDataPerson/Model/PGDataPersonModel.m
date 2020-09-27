#import "PGDataPersonModel.h"
@implementation PGDataPersonModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"dataPersonStatus" : @"IsExamine"
             };
}
@end
