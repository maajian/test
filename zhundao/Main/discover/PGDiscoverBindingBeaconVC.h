#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PGSaoYiSaoViewController.h"
typedef void(^block) (BOOL issuccess);
@interface PGDiscoverBindingBeaconVC : PGSaoYiSaoViewController<AVCaptureMetadataOutputObjectsDelegate>
{
}
@property(nonatomic,copy)block backblock;
@end
