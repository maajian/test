#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,PhotoBroswerVCType) {
    PhotoBroswerVCTypePush=0,
    PhotoBroswerVCTypeModal,
    PhotoBroswerVCTypeZoom,
};
@interface PGActivityImageBrowserVC : UIViewController
+(void)show:(UIViewController *)handleVC type:(PhotoBroswerVCType)type index:(NSUInteger)index imagesBlock:(NSArray *(^)())imagesBlock;
@end
