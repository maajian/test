#import <UIKit/UIKit.h>
typedef void(^backBlock) (NSInteger index);
@interface PGAlertSheet : UIView
@property(nonatomic,copy)backBlock backBlock;
+ (void)showWithArray :(NSArray *)dataArray
   title :(NSString *)title
isDelete :(BOOL)isDelete
          selectBlock :(backBlock)selectBlock;
- (void)fadeIn;
- (instancetype)initWithFrame:(CGRect)frame
                       array :(NSArray *)dataArray
                       title :(NSString *)title
                    isDelete :(BOOL)isDelete
                 selectBlock :(backBlock)selectBlock;
@end
