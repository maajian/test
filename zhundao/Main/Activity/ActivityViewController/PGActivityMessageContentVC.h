#import "PGBaseVC.h"
typedef void(^messageContentBlock) (NSString *contentStr);
@interface PGActivityMessageContentVC : PGBaseVC
@property(nonatomic,assign)NSInteger signCount;
@property(nonatomic,strong)NSArray *contentArray;
@property (nonatomic,assign) NSInteger es_id;
@end
