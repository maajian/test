#import <UIKit/UIKit.h>
typedef void(^reloadBlock) (BOOL isReload);
typedef NS_ENUM(NSInteger,showType) {
    NoNetWork = 0 ,
    HavaNetButNotData = 1
};
@interface PGNoDataScrollView : UIScrollView
@property(nonatomic,copy)reloadBlock reloadBlock1;
- (instancetype)initWithFrame:(CGRect)frame
                   imageName :(NSString *)imageName
                     topText :(NSString *) topText
                  bottomText :(NSString *) bottomText;
- (void) removeNoDataView;
- (void)addGesToScreenWithBlock :(SEL)reloadSEL;
- (void)setData  :(NSString *)imageName
         topText :(NSString *) topText
      bottomText :(NSString *) bottomText;
@end
