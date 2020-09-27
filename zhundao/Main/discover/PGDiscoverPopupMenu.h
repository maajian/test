#import <UIKit/UIKit.h>
#import "PGDiscoverPopupMenuPath.h"
#define YBDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
typedef NS_ENUM(NSInteger , YBPopupMenuType) {
    YBPopupMenuTypeDefault = 0,
    YBPopupMenuTypeDark
};
typedef NS_ENUM(NSInteger , YBPopupMenuPriorityDirection) {
    YBPopupMenuPriorityDirectionTop = 0,  
    YBPopupMenuPriorityDirectionBottom,
    YBPopupMenuPriorityDirectionLeft,
    YBPopupMenuPriorityDirectionRight,
    YBPopupMenuPriorityDirectionNone      
};
@class PGDiscoverPopupMenu;
@protocol YBPopupMenuDelegate <NSObject>
@optional
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index PGDiscoverPopupMenu:(PGDiscoverPopupMenu *)PGDiscoverPopupMenu cell :(UITableViewCell *)cell;
- (void)ybPopupMenuBeganDismiss;
- (void)ybPopupMenuDidDismiss;
- (void)ybPopupMenuBeganShow;
- (void)ybPopupMenuDidShow;
@end
@interface PGDiscoverPopupMenu : UIView
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) UIRectCorner rectCorner;
@property (nonatomic, assign , getter=isShadowShowing) BOOL isShowShadow;
@property (nonatomic, assign) BOOL showMaskView;
@property (nonatomic, assign) BOOL dismissOnSelected;
@property (nonatomic, assign) BOOL dismissOnTouchOutside;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) UIColor * textColor;
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor * borderColor;
@property (nonatomic, assign) CGFloat arrowWidth;
@property (nonatomic, assign) CGFloat arrowHeight;
@property (nonatomic, assign) CGFloat arrowPosition;
@property (nonatomic, assign) YBPopupMenuArrowDirection arrowDirection;
@property (nonatomic, assign) YBPopupMenuPriorityDirection priorityDirection;
@property (nonatomic, assign) NSInteger maxVisibleCount;
@property (nonatomic, strong) UIColor * backColor;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) YBPopupMenuType type;
@property (nonatomic, weak) id <YBPopupMenuDelegate> delegate;
+ (PGDiscoverPopupMenu *)showAtPoint:(CGPoint)point
                     titles:(NSArray *)titles
                      icons:(NSArray *)icons
                  menuWidth:(CGFloat)itemWidth
                   delegate:(id<YBPopupMenuDelegate>)delegate;
+ (PGDiscoverPopupMenu *)showAtPoint:(CGPoint)point
                      titles:(NSArray *)titles
                       icons:(NSArray *)icons
                   menuWidth:(CGFloat)itemWidth
               otherSettings:(void (^) (PGDiscoverPopupMenu * popupMenu))otherSetting;
+ (PGDiscoverPopupMenu *)showRelyOnView:(UIView *)view
                        titles:(NSArray *)titles
                         icons:(NSArray *)icons
                     menuWidth:(CGFloat)itemWidth
                      delegate:(id<YBPopupMenuDelegate>)delegate;
+ (PGDiscoverPopupMenu *)showRelyOnView:(UIView *)view
                         titles:(NSArray *)titles
                          icons:(NSArray *)icons
                      menuWidth:(CGFloat)itemWidth
                  otherSettings:(void (^) (PGDiscoverPopupMenu * popupMenu))otherSetting;
- (void)dismiss;
@end
