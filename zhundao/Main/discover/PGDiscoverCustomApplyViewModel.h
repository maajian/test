#import <Foundation/Foundation.h>
#import "PGDiscoverCustomApplyModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface PGDiscoverCustomApplyViewModel : NSObject
@property (nonatomic, strong) NSMutableArray<PGDiscoverCustomApplyModel *> *dataArray;
@property (nonatomic, strong) NSMutableArray<PGDiscoverCustomApplyModel *> *titleArray;
@property (nonatomic, strong) NSMutableArray<NSString *> *allTitleArray;
- (void)getCustomApplyList:(kZDCommonSucc)success fail:(kZDCommonFail)fail;
- (void)hideOrShowList:(BOOL)hidden ID:(NSInteger)ID success:(kZDCommonSucc)success fail:(kZDCommonFail)fail;
@end
NS_ASSUME_NONNULL_END
