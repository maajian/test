#import "PGAvtivityMoreChioceMV.h"
@implementation PGAvtivityMoreChioceMV
- (CGFloat)heightForCellWithImagearr :(NSArray *) array
{
    NSInteger x =0;    
    for (int i=0; i<array.count+1; i++) {
        x = i/3;
    }
    return 10 +(x+1) *110;
}
@end
