#import <UIKit/UIKit.h>
typedef void(^deleteBlock) (BOOL isDelete);
@interface PGMePersonDetailViewController : PGBaseVC
@property(copy,nonatomic)NSArray *dataArray;
@property(nonatomic,assign)NSInteger personID;
@property(nonatomic,copy) deleteBlock block;
@end
