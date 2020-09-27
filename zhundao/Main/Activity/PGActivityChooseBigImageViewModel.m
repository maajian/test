#import "PGActivityChooseBigImageViewModel.h"
@implementation PGActivityChooseBigImageViewModel
- (NSMutableArray *)heightForCell :(NSArray *) array{
    NSMutableArray *heightArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        NSArray *listArray = dic[@"List"];
        NSInteger height = ((listArray.count-1)/3+1)*75+54;
        [heightArray addObject:@(height)];
    }
    return heightArray;
}
@end
