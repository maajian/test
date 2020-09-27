#import "PGDataPersonAddModel.h"
@implementation PGDataPersonAddModel
+ (instancetype)PG_modelWithContent:(NSString *)content text:(NSString *)text type:(ZDDataPersonAddType)type {
    PGDataPersonAddModel *model = [PGDataPersonAddModel new];
    model.content = content;
    model.text = text;
    model.type = type;
    return model;
}
+ (instancetype)phoneModel {
    return [PGDataPersonAddModel PG_modelWithContent:@"" text:@"手机" type:(ZDDataPersonAddTypePhone)];
}
+ (instancetype)nameModel {
    return [PGDataPersonAddModel PG_modelWithContent:@"" text:@"姓名" type:(ZDDataPersonAddTypeName)];
}
@end
