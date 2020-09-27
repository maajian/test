#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PGDiscoverDetailModel.h"
@protocol detailModelDelegate <NSObject>
- (void)selectIndex :(NSIndexPath *)indexPath;
@end
@interface PGDiscoverShakeTableViewDelegateObj : NSObject<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)PGDiscoverDetailModel *model;
@property(nonatomic,copy)NSDictionary  *datadic;
@property(nonatomic,weak) id<detailModelDelegate>  detailModelDelegate;
+(instancetype)createTableViewDelegateWithDataList:(PGDiscoverDetailModel *)model
                                          withdic :(NSDictionary *)dic;
@end
