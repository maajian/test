#import "PGActivityMessageContentViewModel.h"
#import "PGActivityMessageContentModel.h"
@implementation PGActivityMessageContentViewModel
- (instancetype)init {
    if (self = [super init]) {
        _customHeightArray = [NSMutableArray array];
        _systemHeightArray = [NSMutableArray array];
        _systemArray = [NSMutableArray array];
        _customArray = [NSMutableArray array];
    }
    return self;
}
- (void)deleteContent :(NSInteger )ID
                  esid:(NSInteger)esid
          successBlock:(ZDSuccessBlock)successBlock
                 error:(ZDErrorBlock)errorBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/sms/DeleteTemplate?id=%li&esid=%li",zhundaoMessageApi,ID,esid];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        successBlock(obj);
    } fail:^(NSError *error) {
        errorBlock(error);
    }];
}
- (void)addContent :(NSString * )content
                 ID:(NSInteger)ID
          successBlock:(ZDSuccessBlock)successBlock
                 error:(ZDErrorBlock)errorBlock{
    NSString *str = [NSString stringWithFormat:@"%@api/sms/AddTemplate",zhundaoMessageApi];
    NSDictionary *dic = @{@"es_id" :@(ID),
                          @"es_content" :content,
                          @"es_sort" : @(1),
                          @"remark" : @""
                          };
    [ZD_NetWorkM postDataWithMethod:str parameters:dic succ:^(NSDictionary *obj) {
        successBlock(obj);
    } fail:^(NSError *error) {
        errorBlock(error);
    }];
}
- (void)getSystemWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Dic)success failure:(ZDBlock_Error_Str)failure {
    NSDictionary *dic = @{@"SortId" : @(1),
                          @"PageSize" : @(1000),
                          @"PageIndex" : [NSString stringWithFormat:@"%li",pageIndex]
                          };
    NSString *str = [NSString stringWithFormat:@"%@api/sms/GetDefaultTemplateList",zhundaoMessageApi];
    [ZD_NetWorkM postDataWithMethod:str parameters:dic succ:^(NSDictionary *obj) {
        [_systemArray removeAllObjects];
        [_systemHeightArray removeAllObjects];
        for (NSDictionary *dic in obj[@"data"]) {
            PGActivityMessageContentModel *model = [[PGActivityMessageContentModel alloc] initWithDic:dic];
            model.isSystem = YES;
            [self.systemArray addObject:model];
            NSString *content = model.es_content;
            CGSize size = [content boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
            [self.systemHeightArray addObject:@(size.height + 20)];
        }
        success(obj);
    } fail:^(NSError *error) {
        failure(error.description);
    }];
}
- (void)getCustomWithPageIndex:(NSInteger)pageIndex EsID:(NSInteger)EsID success:(ZDBlock_Dic)success failure:(ZDBlock_Error_Str)failure {
    NSDictionary *dic = @{@"SortId" : @(1),
                          @"PageSize" : @(1000),
                          @"PageIndex" : [NSString stringWithFormat:@"%li",pageIndex],
                          @"EsID" : @(EsID),
                          @"Status": @(-2)
                          };
    NSString *str = [NSString stringWithFormat:@"%@api/sms/GetTemplateList",zhundaoMessageApi];
    [ZD_NetWorkM postDataWithMethod:str parameters:dic succ:^(NSDictionary *obj) {
        [_customArray removeAllObjects];
        [_customHeightArray removeAllObjects];
        for (NSDictionary *dic in obj[@"data"]) {
            PGActivityMessageContentModel *model = [[PGActivityMessageContentModel alloc] initWithDic:dic];
            model.isSystem = NO;
            [self.customArray addObject:model];
            NSString *content = model.es_content;
            CGSize size = [content boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
            [self.customHeightArray addObject:@(size.height + 40)];
        }
        success(obj);
    } fail:^(NSError *error) {
        failure(error.description);
    }];
}
@end
