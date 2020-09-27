#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, LMTextAttachmentType) {
    LMTextAttachmentTypeImage,
    LMTextAttachmentTypeCheckBox,
};
@interface NSTextAttachment (LMText)
+ (instancetype)checkBoxAttachment;
+ (instancetype)attachmentWithImage:(UIImage *)image width:(CGFloat)width;
@property (nonatomic, assign) LMTextAttachmentType attachmentType;
@property (nonatomic, strong) id userInfo;
@end
