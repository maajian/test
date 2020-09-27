#import "PGWebViewController.h"
typedef void(^successBlock) (BOOL issuccess);
@interface PGSignInUpDataVC : PGWebViewController
@property(nonatomic,copy)successBlock block;
@property (nonatomic, assign) BOOL isPresent;
@end
