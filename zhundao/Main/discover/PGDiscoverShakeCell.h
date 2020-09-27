#import <UIKit/UIKit.h>
#import "PGDiscoverShakeModel.h"
#import "PGDiscoverFaceModel.h"
@interface PGDiscoverShakeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconUrlImageView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *beconnameDevidedID;
@property(nonatomic,strong)PGDiscoverShakeModel *model;
@property(nonatomic,strong)PGDiscoverFaceModel *faceModel;
@end
