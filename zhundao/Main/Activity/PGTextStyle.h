#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, LMTextStyleType) {
    LMTextStyleFormatNormal = 0,
    LMTextStyleFormatTitleSmall,
    LMTextStyleFormatTitleMedium,
    LMTextStyleFormatTitleLarge,
};
@interface PGTextStyle : NSObject
@property (nonatomic, assign) BOOL bold;
@property (nonatomic, assign) BOOL italic;
@property (nonatomic, assign) BOOL underline;
@property (nonatomic, assign) float fontSize;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, readonly) UIFont *font;
@property (nonatomic, readonly) LMTextStyleType type;
+ (instancetype)textStyleWithType:(LMTextStyleType)type;
@end
