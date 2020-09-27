#import <UIKit/UIKit.h>
@class PGWordView;
@interface PGWordViewController : PGBaseVC
@property (nonatomic, strong) PGWordView *textView;
@property(nonatomic,copy)NSArray *imageArray;
- (NSString *)exportHTML;
@end
