#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ZDDataPersonAddType) {
    ZDDataPersonAddTypeName,
    ZDDataPersonAddTypePhone,
};
NS_ASSUME_NONNULL_BEGIN
@interface PGDataPersonAddModel : NSObject
@property (nonatomic, assign) ZDDataPersonAddType type;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *content;
+ (instancetype)phoneModel;
+ (instancetype)nameModel;
@end
NS_ASSUME_NONNULL_END
