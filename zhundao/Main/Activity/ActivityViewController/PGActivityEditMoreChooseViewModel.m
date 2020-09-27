#import "PGActivityEditMoreChooseViewModel.h"
@implementation PGActivityEditMoreChooseViewModel
- (NSMutableArray *)getIndexArrayFromArray :(NSArray *)nowArray allArray :(NSArray *)allArray
{
    NSMutableArray *indexArray = [NSMutableArray array];
    for (int i = 0; i< allArray.count; i++) {
        [indexArray addObject:@"0"];
    }
    for (int i = 0; i < nowArray .count; i++) {
        for ( int j = 0; j <allArray.count; j++) {
            if ([nowArray[i] isEqualToString:allArray[j]]) {
                [indexArray replaceObjectAtIndex:j withObject:@"1"];
                break;
            }
        }
    }
    return indexArray;
}
@end
