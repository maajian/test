#import <UIKit/UIKit.h>
@class PGTextStyle;
@class PGParagraphConfig;
@protocol PGStyleSettingsControllerDelegate <NSObject>
- (void)lm_didChangedTextStyle:(PGTextStyle *)textStyle;
- (void)lm_didChangedParagraphIndentLevel:(NSInteger)level;
- (void)lm_didChangedParagraphType:(NSInteger)type;
@end
@interface PGStyleSettingsController : UITableViewController
@property (nonatomic, weak) id<PGStyleSettingsControllerDelegate> delegate;
@property (nonatomic, strong) PGTextStyle *textStyle;
- (void)reload;
- (void)setParagraphConfig:(PGParagraphConfig *)paragraphConfig;
@end
