#import <UIKit/UIKit.h>
#import "PGStatisticsModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface PGStatisticsBottomView : UIView
@property (nonatomic, strong) NSMutableArray<PGStatisticsModel *> *dataSource;
@end
NS_ASSUME_NONNULL_END
