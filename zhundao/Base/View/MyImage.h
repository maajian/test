#import <UIKit/UIKit.h>
@interface MyImage : UIImageView
+(UIImageView *)initWithImageFrame:(CGRect)frame imageName:(NSString *)imageName cornerRadius :(float)cornerRadius masksToBounds:(BOOL)masksToBounds;
@end
