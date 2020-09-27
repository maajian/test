#import "UIImageView+nullData.h"
@implementation UIImageView (nullData)
+ (UIImageView *)initWithFrame :(CGRect)rect  imageName:(NSString *)str
{
    UIImageView *imageview = [[ UIImageView alloc]initWithFrame:rect];
    imageview.image = [UIImage imageNamed:str];
    return  imageview;
}
@end
