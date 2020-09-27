#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, PGMessageStatusType) {
    PGMessageStatusTypeSuccess,
    PGMessageStatusTypeFail,
    PGMessageStatusTypeCheck
};
@interface PGActivityMessageContentModel : NSObject
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *es_content;
@property (nonatomic, copy) NSString *Reason;
@property (nonatomic, assign) PGMessageStatusType messageStatusType;
- (instancetype)initWithDic:(NSDictionary *)dic;
@property (nonatomic, assign) BOOL isSystem;
@property (nonatomic, assign) CGFloat cellHeight;
@end
