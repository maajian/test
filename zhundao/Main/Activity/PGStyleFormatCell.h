#import <UIKit/UIKit.h>
#import "PGStyleSettings.h"
@interface PGStyleFormatCell : UITableViewCell
@property (nonatomic, weak) id<PGStyleSettings> delegate;
@property (nonatomic, assign) NSInteger selectedIndex;
@end
