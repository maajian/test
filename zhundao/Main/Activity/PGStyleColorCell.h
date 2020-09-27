#import <UIKit/UIKit.h>
#import "PGStyleSettings.h"
@interface PGStyleColorCell : UITableViewCell
@property (nonatomic, weak) id<PGStyleSettings> delegate;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, copy) NSArray *colors;
@end
