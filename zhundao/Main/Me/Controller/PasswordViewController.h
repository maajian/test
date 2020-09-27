#import "PGBaseVC.h"
typedef enum : NSUInteger {
    Old, 
    New, 
    ReNew, 
} payState;
@interface PasswordViewController : PGBaseVC
@property(nonatomic,assign)payState state;
@property(nonatomic,copy)NSString *password;
@end
