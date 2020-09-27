#import "PGDiscoverCustomModel.h"
@implementation PGDiscoverCustomModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.ID = [dic[@"id"] integerValue];
        self.Title = dic[@"title"];
        self.Option = dic[@"option"];
        self.Required = [dic[@"required"] boolValue];
        self.Hidden = [dic[@"hidden"] boolValue];
        self.InputType = [dic[@"inputType"] integerValue];
    }
    return self;
}
@end
