#import "PGBaseVC.h"
typedef void(^faceBlock) (BOOL ischange);
@class PGDiscoverFaceModel;
@interface PGDiscoverFaceDetailVC : PGBaseVC
@property(nonatomic,strong)PGDiscoverFaceModel *model;
@property(nonatomic,copy)faceBlock faceBlock;
@end
