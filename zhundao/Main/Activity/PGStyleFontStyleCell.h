#import <UIKit/UIKit.h>
#import "PGStyleSettings.h"
@interface PGStyleFontStyleCell : UITableViewCell
@property (nonatomic, weak) id<PGStyleSettings> delegate;
@property (nonatomic, assign) BOOL bold;
@property (nonatomic, assign) BOOL italic;
@property (nonatomic, assign) BOOL underline;
@end
