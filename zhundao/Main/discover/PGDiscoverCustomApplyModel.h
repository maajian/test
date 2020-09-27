#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ZDCustomType) {
    ZDCustomTypeOneText = 0, 
    ZDCustomTypeMoreText, 
    ZDCustomTypePullDown, 
    ZDCustomTypeMoreChoose, 
    ZDCustomTypeImage, 
    ZDCustomTypeOneChoose, 
    ZDCustomTypeDate, 
    ZDCustomTypeNumber, 
};
@interface PGDiscoverCustomApplyModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger required;
@property (nonatomic, assign) ZDCustomType customType;
@property (nonnull, assign) NSString *typeStr;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *option;
@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, assign) NSString *placeholder;
@property (nonatomic, copy) NSArray *optionArray;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end
NS_ASSUME_NONNULL_END
