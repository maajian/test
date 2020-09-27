#import "MyImage.h"
@implementation MyImage
+(UILabel *)initWithImageFrame:(CGRect)frame imageName:(NSString *)imageName cornerRadius :(float)cornerRadius masksToBounds:(BOOL)masksToBounds
{
    return  [[self alloc]initWithImageFrame:frame imageName:imageName cornerRadius:cornerRadius masksToBounds:masksToBounds];
}
- (instancetype)initWithImageFrame:(CGRect)frame imageName:(NSString *)imageName cornerRadius :(float)cornerRadius masksToBounds:(BOOL)masksToBounds
{
    if (self= [super init]) {
        self.frame = frame;
        self.image = [UIImage imageNamed:imageName];
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = masksToBounds;
    }
    return self;
}
@end
