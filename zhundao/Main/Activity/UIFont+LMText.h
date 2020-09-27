#import <UIKit/UIKit.h>
@interface UIFont (LMText)
@property (nonatomic, readonly) BOOL bold;
@property (nonatomic, readonly) BOOL italic;
@property (nonatomic, readonly) float fontSize;
+ (instancetype)lm_fontWithFontSize:(float)fontSize bold:(BOOL)bold italic:(BOOL)italic;
@end
