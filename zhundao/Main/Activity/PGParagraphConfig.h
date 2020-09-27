#import <UIKit/UIKit.h>
extern NSString * const LMParagraphTypeName;
extern NSString * const LMParagraphIndentName;
typedef NS_ENUM(NSUInteger, LMParagraphType) {
    LMParagraphTypeNone = 0,
    LMParagraphTypeList,
    LMParagraphTypeNumberList,
    LMParagraphTypeCheckbox
};
@interface PGParagraphConfig : NSObject
@property (nonatomic, assign) LMParagraphType type;
@property (nonatomic, assign) NSInteger indentLevel;
@property (nonatomic, readonly) NSParagraphStyle *paragraphStyle;
- (instancetype)initWithParagraphStyle:(NSParagraphStyle *)paragraphStyle type:(LMParagraphType)type;
@end
