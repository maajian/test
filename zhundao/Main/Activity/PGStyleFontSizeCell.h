#import <UIKit/UIKit.h>
#import "PGStyleSettings.h"
@interface PGStyleFontSizeCell : UITableViewCell
@property (nonatomic, weak) id<PGStyleSettings> delegate;
@property (nonatomic, copy) NSArray<NSNumber *> *fontSizeNumbers;
@property (nonatomic, assign) NSInteger currentFontSize;
@end
