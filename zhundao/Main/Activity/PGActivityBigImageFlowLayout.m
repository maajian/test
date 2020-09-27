#import "PGActivityBigImageFlowLayout.h"
static const CGFloat itemSpace = 10;
static const CGFloat itemHeight = 70;
@implementation PGActivityBigImageFlowLayout
- (instancetype)init{
    if (self = [super init]) {
        self.itemSize = CGSizeMake((kScreenWidth- 4*itemSpace - 1)/3, itemHeight);
        self.minimumInteritemSpacing = itemSpace;
        self.minimumLineSpacing = itemSpace/2;
        self.sectionInset =UIEdgeInsetsMake(0, itemSpace, 0, itemSpace);
        self.headerReferenceSize = CGSizeMake(kScreenWidth, 40);
    }
    return self;
}
@end
