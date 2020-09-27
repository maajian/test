#import <Foundation/Foundation.h>
@interface PGDiscoverCustomModel : NSObject
@property(nonatomic,strong)NSString *Title;
@property(nonatomic,assign)NSInteger Required;
@property(nonatomic,assign)NSInteger InputType;
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,strong)NSString *Option;
@property (nonatomic, assign) BOOL Hidden;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end
