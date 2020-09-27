#import <UIKit/UIKit.h>
@class GZActionSheet;
@protocol GZActionSheetDelegate <NSObject>
- (void)actionSheet:(GZActionSheet *)actionSheet clickButtonAtIndex:(NSInteger )buttonIndex;
@end
@interface GZActionSheet : UIView
@property (nonatomic,weak) id <GZActionSheetDelegate> delegate;
@property (nonatomic,copy) void (^ClickIndex) (NSInteger index);
- (instancetype)initWithTitleArray:(NSArray *)titleArr
                     WithRedIndex :(NSInteger)index
                     andShowCancel:(BOOL )show;
@end
