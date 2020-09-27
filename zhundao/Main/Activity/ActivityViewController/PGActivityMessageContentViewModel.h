#import <Foundation/Foundation.h>
#import "PGActivityMessageContentModel.h"
#import "NSObject+block.h"
@interface PGActivityMessageContentViewModel : NSObject
#pragma mark--- 网络请求
- (void)deleteContent :(NSInteger )ID
                  esid:(NSInteger)esid
          successBlock:(ZDSuccessBlock)successBlock
                 error:(ZDErrorBlock)errorBlock;
- (void)addContent :(NSString * )content
                 ID:(NSInteger)ID
       successBlock:(ZDSuccessBlock)successBlock
              error:(ZDErrorBlock)errorBlock;
- (void)getSystemWithPageIndex:(NSInteger)pageIndex success:(ZDBlock_Dic)success failure:(ZDBlock_Error_Str)failure ;
- (void)getCustomWithPageIndex:(NSInteger)pageIndex EsID:(NSInteger)EsID success:(ZDBlock_Dic)success failure:(ZDBlock_Error_Str)failure ;
@property (nonatomic, strong) NSMutableArray *systemHeightArray;
@property (nonatomic, strong) NSMutableArray<PGActivityMessageContentModel *> *systemArray;
@property (nonatomic, strong) NSMutableArray *customHeightArray;
@property (nonatomic, strong) NSMutableArray<PGActivityMessageContentModel *> *customArray;
@end
