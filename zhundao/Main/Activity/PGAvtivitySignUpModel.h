#import <Foundation/Foundation.h>
@interface PGAvtivitySignUpModel : NSObject
@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat amount;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end
