#import <UIKit/UIKit.h>
typedef void(^postBlock1) (NSAttributedString *text,NSString *htmlstr,NSString *titletext);
@interface PGActivityEditWebVC : PGBaseVC
@property(nonatomic,copy)postBlock1 block;
@property(nonatomic,copy)NSAttributedString *pushText;
@property(nonatomic,copy)NSArray *imageArray;
@end
