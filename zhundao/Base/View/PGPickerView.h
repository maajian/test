#import <UIKit/UIKit.h>
typedef void(^backPickerBlock)(NSString  *str);
@interface PGPickerView : UIView
@property(nonatomic,copy)backPickerBlock backBlock;
- (instancetype)initWithFrame:(CGRect)frame
                   dataArray : (NSArray *)dataArray
                  currentStr :(NSString *)str
                   backBlock :(backPickerBlock)selectBlock ;
- (void)fadeIn; 
@end
